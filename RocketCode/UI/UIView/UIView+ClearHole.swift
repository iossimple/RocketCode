//
//  UIView+ClearHole.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-15.
//

import UIKit

public extension UIView {
    func makeClearHole(rect: CGRect) {
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.fillColor = UIColor.black.cgColor
        
        let pathToOverlay = UIBezierPath(rect: self.bounds)
        pathToOverlay.append(UIBezierPath(rect: rect))
        pathToOverlay.usesEvenOddFillRule = true
        maskLayer.path = pathToOverlay.cgPath
        
        layer.mask = maskLayer
    }
}
