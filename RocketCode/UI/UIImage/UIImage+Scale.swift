//
//  UIImage+Scale.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-21.
//

import UIKit

public extension UIImage {
    // scale: defaults to 0, means device's scale
    class func resize(image: UIImage, targetSize: CGSize, scale: CGFloat = 0) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func scale(image: UIImage, by factor: CGFloat) -> UIImage? {
        let size = image.size
        let scaledSize = CGSize(width: size.width * factor, height: size.height * factor)
        return UIImage.resize(image: image, targetSize: scaledSize, scale: image.scale)
    }
}
