//
//  UIButton+ImageLayout.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-09.
//

import UIKit

public extension UIButton {
    func setImageContentMode(_ mode: UIView.ContentMode) {
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        imageView?.contentMode = mode
    }
}
