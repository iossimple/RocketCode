//
//  AutoHeightImageView.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-07-01.
//

import UIKit

class AutoHeightImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        if let image = self.image {
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            
            let viewWidth = self.frame.size.width
            let viewHeight = viewWidth * imageHeight / imageWidth
            
            return CGSize(width: viewWidth, height: viewHeight)
        }
        
//        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
        return super.intrinsicContentSize
    }
    
}

class AutoWidthImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        if let image = self.image {
            let imageWidth = image.size.width
            let imageHeight = image.size.height
            
            
            let viewHeight = self.frame.size.height
            let viewWidth = viewHeight * imageWidth / imageHeight
            
            return CGSize(width: viewWidth, height: viewHeight)
        }
        
//        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
        return super.intrinsicContentSize
    }
}
