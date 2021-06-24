//
//  GradientView.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-10.
//

import UIKit

//class GradientView: UIView {
//
//    override func draw(_ rect: CGRect) {
//        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
//        let context: CGContext = UIGraphicsGetCurrentContext()!
//        context.saveGState()
//
//        let startColor: UIColor = UIColor(red: 79.0/255.0, green: 30.0/255.0, blue: 122.0/255.0, alpha: 1.0)
//        let endColor: UIColor = UIColor(red: 46.0/255.0, green: 12.0/255.0, blue: 80.0/255.0, alpha: 1.0)
//        let colors = [startColor.cgColor, endColor.cgColor]
//        let locations: [CGFloat] = [0, 1]
//        let gradient: CGGradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)!
//
//        let startPoint: CGPoint = CGPoint(x:rect.midX, y: rect.minY)
//        let endPoint: CGPoint = CGPoint(x: rect.midX, y: rect.maxY)
//
//        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
//        context.restoreGState()
//    }
//
//}

public class GradientView: UIView {
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


