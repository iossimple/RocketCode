//
//  UIImageView+Remote.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-14.
//

import UIKit
import SDWebImage

public extension UIImageView {
    func showNetworkImage(link: String, completion: ((_ isOK: Bool) -> Void)? = nil ) {
        sd_imageIndicator = SDWebImageProgressIndicator.`default`
        sd_setImage(with: URL(string: link)) {
            [weak self] img, _, _, _ in
            
            if let img = img { self?.image = img; completion?(true) }
            else { completion?(false) }
        }
    }
    
    func clearNetworkImage() {
        sd_cancelCurrentImageLoad()
        image = nil
    }
}
