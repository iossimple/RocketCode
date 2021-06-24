//
//  UIViewController+OpenLink.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-14.
//

import UIKit
import SafariServices

public extension UIViewController {
    func openLink(_ link: String) {
      guard let url = URL(string: link) else { return }
      let web = SFSafariViewController(url: url)
      present(web, animated: true, completion: nil)
    }
}
