//
//  UIView+Shadow.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-29.
//

import UIKit

public extension UIView {
    // https://stackoverflow.com/a/48489506/566360
    // https://sarunw.com/posts/match-view-shadow-to-sketch-shadow/
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        //    shadowRadius = blur / 2.0
        layer.shadowRadius = blur / UIScreen.main.scale
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
