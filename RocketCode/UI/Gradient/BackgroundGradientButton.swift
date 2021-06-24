//
//  BackgroundGradientButton.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-16.
//

import UIKit

public class BackgroundGradientButton: UIButton {
    public enum Direction {
        case vertical // top -> bottom
        case horizontal // left -> right
    }
    
    public override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    public func makeGradient(direction: Direction, startColor: UIColor, endColor: UIColor) {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        switch direction {
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        }
    }
}
