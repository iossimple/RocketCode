//
//  UIViewController+Container.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-17.
//

import UIKit

// Container View Controller: https://developer.apple.com/documentation/uikit/view_controllers/creating_a_custom_container_view_controller
public extension UIViewController {
    func containerAdd(child: UIViewController, containerView: UIView? = nil) {
        addChild(child)
        (containerView ?? view).addSubview(child.view)
        child.view.pinToSuperview()
        child.didMove(toParent: self)
    }
    
    func containerRemove(child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
