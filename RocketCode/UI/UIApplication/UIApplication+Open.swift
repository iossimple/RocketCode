//
//  UIApplication+Open.swift
//  AFDateHelper
//
//  Created by Viet Nguyen Tran on 2021-06-23.
//

import UIKit

public extension UIApplication {
    func openSettings() {
        open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    func openLink(_ link: String) {
        guard let url = URL(string: link)
        else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
