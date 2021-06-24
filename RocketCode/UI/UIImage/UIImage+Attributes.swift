//
//  UIImage+Attributes.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-18.
//

import UIKit

public extension UIImage {
    /// Checks if image has alpha component
    var hasAlpha: Bool {
      let result: Bool

      guard let alpha = cgImage?.alphaInfo else {
        return false
      }

      switch alpha {
      case .none, .noneSkipFirst, .noneSkipLast:
        result = false
      default:
        result = true
      }

      return result
    }
}
