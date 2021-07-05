//
//  VerticalButton.swift
//  VerticalButton
//
//  Created by Masher Shin on 2/15/17.
//  Copyright © 2017 Masher Shin. All rights reserved.
//

import UIKit

@available(iOS 13, *)
@IBDesignable
open class VerticalButton: UIButton {
    @IBInspectable
    open var spacing: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
            invalidateIntrinsicContentSize()
        }
    }
    
    @IBInspectable
    open var verticalPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            setNeedsDisplay()
            invalidateIntrinsicContentSize()
        }
    }
    
    private func configure() {
        let imageSize = imageView?.frame.size ?? CGSize(width: 0, height: 0)
        
        let titleSize = titleLabel?.frame.size ?? CGSize(width: 0, height: 0)
        
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing) - verticalPoint.y,
                                       left: 0 - verticalPoint.x,
                                       bottom: spacing + verticalPoint.y,
                                       right: -titleSize.width + verticalPoint.x)
    
        titleEdgeInsets = UIEdgeInsets(top: 0 - verticalPoint.y,
                                       left: -imageSize.width - verticalPoint.x,
                                       bottom: -(imageSize.height + spacing) + verticalPoint.y,
                                       right: 0 + verticalPoint.x)
    }
    
    override open func layoutSubviews() {
        configure()
        invalidateIntrinsicContentSize()
        super.layoutSubviews()
    }
    
    override open var intrinsicContentSize: CGSize {
        let imageSize = imageView?.frame.size ?? CGSize(width: 0, height: 0)
        // Fix: title not display normally in XIB
        titleLabel?.sizeToFit()
        let titleSize = titleLabel?.frame.size ?? CGSize(width: 0, height: 0)
        return CGSize(width: max(imageSize.width, titleSize.width),
                      height: imageSize.height + titleSize.height + spacing + 12) // 12 = top margin + bottom margin
    }
}
