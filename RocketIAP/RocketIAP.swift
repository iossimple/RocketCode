//
//  RocketIAP.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-24.
//

import Foundation
import StoreKit
import TPInAppReceipt
import SwiftNotificationCenter

public protocol IAPServiceUpdate {
    func updatePremiumStatus(_ iapService: IAPService)
    func updateProductList(_ iapService: IAPService)
    //  func updatePurchasingStatus(_ iapService: IAPService)
}

public extension String {
    func packageIDtoIAPPriceString() -> String {
        return IAPService.shared.convertPackageIDtoPriceString(self)
    }
}

extension IAPService {
    func convertPackageIDtoPriceString(_ packageID: String) -> String {
        let matchingProduct = self.availablePackages.first { $0.productIdentifier == packageID }
        guard let p = matchingProduct
        else { return "" }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = p.priceLocale
        
        return formatter.string(from: p.price) ?? ""
    }
}

public class IAPService: NSObject {
    public static let shared = IAPService()
    
    public func startWithIDs(_ ids: [String]) {
        validateReceipt()
        loadAppStoreProductInfo(inputIDs: ids)
    }
    
    // Premium status (by receipt validator)
    public var isPremiumSubscribed: Bool {
        return activeAutoRenewableSubscriptionID != nil
    }
    public var isPremiumChecking: Bool { return isReceiptValidating } // by validator status
    
    public var currentPremiumPackageID: String {
        return activeAutoRenewableSubscriptionID ?? ""
    }
    private var isReceiptValidating: Bool = false {
        didSet {
            Broadcaster.notify(IAPServiceUpdate.self) { [unowned self] in $0.updatePremiumStatus(self)
            }
        }
    }
    private var activeAutoRenewableSubscriptionID: String? = nil
    
    // Available packages (by SKProductsRequest)
    public var isLoadingAvailablePackages: Bool {
        return isProductListLoading
    }
    public var availablePackages: [SKProduct] {
        return productsInfo.availableList
    }
    public var invalidInputIDs: [String] {
        return productsInfo.invalidInputIDs
    }
    
    private var productsRequest: SKProductsRequest!
    private var productsInfo: (availableList: [SKProduct], invalidInputIDs: [String]) = ([], [])
    private var isProductListLoading: Bool = false {
        didSet {
            Broadcaster.notify(IAPServiceUpdate.self) { [unowned self] in $0.updateProductList(self)
            }
        }
    }
    
    // Purchase, Restore
    public func purchase(packageID: String) {
        guard let productToBuy = (availablePackages.first { $0.productIdentifier == packageID })
        else {
            print("no matching product. request \(packageID). available: \(availablePackages.map { $0.productIdentifier })")
            // TODO: alert
            return
        }
        
        let payment = SKMutablePayment(product: productToBuy)
        SKPaymentQueue.default().add(payment)
    }
    
    public func restore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

// Receipt validating
// cases:
//      - ok & has product -> premium
//      - ok & no product -> free
//      - failed -> somthing wrong (connection, hacked, ...) -> free

private extension IAPService {
    
    func validateReceipt() {
        // ok: -> update status
        // invalid:
        //    -> 1st time in a new cycle: refresh receipt, then validate one more time
        //    -> 2st time in a cycle: update status 'failed'
        
        func validate(needsRetry: Bool) {
            isReceiptValidating = true
            
            if let receipt = try? InAppReceipt.localReceipt(),
               let _ = try? receipt.verify() // verifying by InAppReceipt
            {
                let test = receipt.activeAutoRenewableSubscriptionPurchases
                print("==== active count: \(test.count)")
                test.forEach { print($0.productIdentifier) }
                
                let ID = receipt.activeAutoRenewableSubscriptionPurchases.first?.productIdentifier
                activeAutoRenewableSubscriptionID = ID
                isReceiptValidating = false
            }
            else {
                if needsRetry {
                    InAppReceipt.refresh { (_) in
                        validate(needsRetry: false)
                    }
                }
                else { // invalid
                    activeAutoRenewableSubscriptionID = nil
                    isReceiptValidating = false
                }
            }
        }
        
        validate(needsRetry: true)
    }
}

// Get information about Subscription Products
extension IAPService: SKProductsRequestDelegate, SKRequestDelegate {
    private func loadAppStoreProductInfo(inputIDs: [String]) {
        productsRequest = SKProductsRequest(productIdentifiers: Set(inputIDs))
        productsRequest.delegate = self
        isProductListLoading = true
        productsRequest.start()
    }
    
    // SKProductsRequestDelegate
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        productsInfo = (response.products, response.invalidProductIdentifiers)
        isProductListLoading = false
    }
    
    // SKRequestDelegate
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        productsInfo = ([], [])
        isProductListLoading = false
    }
}

// Purchasing
extension IAPService: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing, .deferred: // just do nothing
                break
            case .purchased, .restored, .failed:
                print("==== transaction: \(transaction.payment.productIdentifier)")
                // call this as Appple's documents
                SKPaymentQueue.default().finishTransaction(transaction)
                
                // do another receipt validating
                validateReceipt()
            @unknown default:
                break
            }
        }
    }
}

class RocketIAP {
    
}


