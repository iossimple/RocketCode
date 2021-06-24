//
//  RocketAdmob.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-24.
//

import Foundation
import GoogleMobileAds

enum RocketAdmob {
  // Tutorial link: https://developers.google.com/admob/ios/banner
  // Subclass to convert delegate to callback closure
  class BannerAdView: GADBannerView {
    
    static func factory(adUnitID: String, vcToDisplay: UIViewController, didReceiveAd: (() -> Void)? = nil) -> BannerAdView {
//      let b = BannerView(adSize: kGADAdSizeSmartBannerPortrait)
      let b = BannerAdView()
      b.adUnitID = adUnitID
      b.rootViewController = vcToDisplay
      
      b.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.safeSize.width)
      
      // convert delegate to callback closure
      let strongDelegate = StrongDelegate()
      strongDelegate.successCallback = didReceiveAd
      b.delegate = strongDelegate
      b.strongDelegate = strongDelegate // keep a strong reference
      
//      b.isAutoloadEnabled = true
      b.load(GADRequest())
      
      return b
    }
    
    private var strongDelegate: StrongDelegate!
    
    class StrongDelegate: NSObject, GADBannerViewDelegate {
      var successCallback: (() -> Void)?
      
      // delegate method
      func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("banner didReceive")
        successCallback?()
        successCallback = nil // want to call this callback only one time per view
      }
      
      func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("banner didFail \(error)")
      }
    }
  }
}

extension RocketAdmob {
  class FullscreenAd: NSObject, GADFullScreenContentDelegate {
    static func factory(adID: String) -> FullscreenAd? {
      let adWrapper = FullscreenAd()
      
      let request = GADRequest()
      GADInterstitialAd.load(withAdUnitID: adID,
                             request: request,
                             completionHandler: { (ad, error) in
                              if let error = error {
                                print("Interstitial completionHandler failed: \(error)")
                                return
                              }
                              
                              print("Interstitial completionHandler success")
                              
                              adWrapper.gadAd = ad
                              adWrapper.gadAd?.fullScreenContentDelegate = adWrapper
                              //                              self.interstitial = ad
                              //                              self.interstitial.fullScreenContentDelegate = self
                             }
      )
      
      return adWrapper
    }
    
    private var gadAd: GADInterstitialAd?
    private var dismissCallback: (() -> Void)? = nil
    
    func isReady() -> Bool {
      return gadAd != nil
    }
    
    func show(inVC vc: UIViewController, dismissCallback c: (() -> Void)? = nil) {
      dismissCallback = c
      
      if let ad = gadAd {
//        ad.fullScreenContentDelegate = self
        ad.present(fromRootViewController: vc)
      } else {
        DispatchQueue.main.async { [weak self] in
          self?.dismissCallback?()
        }
      }
    }
    
    // GADInterstitialDelegate
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Interstitial adDidPresentFullScreenContent")
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Interstitial didFailToPresentFullScreenContentWithError: \(error)")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      dismissCallback?()
    }
  }
}
