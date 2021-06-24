//
//  UIView+Subviews.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-21.
//

import UIKit

public extension UIView {
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func findFirst<T:UIView>(_ ofType:T.Type) -> T? {
        if let test = subviews.first(where: { $0 is T }) as? T {
            return test
        } else {
            for view in subviews {
                return view.findFirst(ofType)
            }
        }
        return nil
    }
}
