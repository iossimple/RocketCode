//
//  UIViewController+LoadingView.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-21.
//

import UIKit
import SVProgressHUD

public extension UIViewController {
    func showLoadingHUD() {
      SVProgressHUD.show()
    }
    
    func hideLoadingHUD() {
      SVProgressHUD.dismiss()
    }
    
    func showSuccessHUD(_ message: String? = nil) {
      SVProgressHUD.showSuccess(withStatus: message ?? "Success")
    }
    
    func showFailedHUD(_ message: String? = nil) {
      SVProgressHUD.showError(withStatus: message ?? "Failed")
    }
}
