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
    
    // https://geek-is-stupid.github.io/2016-08-21-how-to-align-vertical-image-and-title-in-an-uibutton/
    func verticalAlign(spacing: CGFloat = 4.0) {
        let imageSize = imageView!.frame.size
        let titleSize = titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + spacing
        
        imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )
        
        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
    
    func spacing(_ value: CGFloat) {
        var contentInsets = contentEdgeInsets
        contentInsets.right += value
        
        contentEdgeInsets = contentInsets
        titleEdgeInsets = UIEdgeInsets.right(0-value)
    }
}
