//
//  UIButton+NetworkImage.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-14.
//

import UIKit
import SDWebImage

public extension UIButton {
    func showNetworkImage(link: String, completion: ((_ isOK: Bool) -> Void)? = nil ) {
        self.sd_imageIndicator = SDWebImageProgressIndicator.`default`
        self.sd_setImage(with: URL(string: link), for: .normal) {
            [weak self] img, _, _, _ in
            if let img = img { self?.setImage(img, for: .normal); completion?(true) }
            else { completion?(false) }
        }
    }
}
