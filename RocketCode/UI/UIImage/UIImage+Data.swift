//
//  UIImage+Data.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-18.
//

import UIKit

extension UIImage {
    /// Convert to data
    func toData(compressionQuality: CGFloat = 1.0) -> Data? {
        return compressionQuality == 1.0 && hasAlpha
        ? pngData()
        : jpegData(compressionQuality: compressionQuality)
    }
}
