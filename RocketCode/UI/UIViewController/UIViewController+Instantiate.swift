//
//  UIViewController+Instantiate.swift
//  RocketCode
//
//  Created by Viet Nguyen Tran on 2021-06-29.
//

import UIKit

public extension UIViewController {
    static func instanceFromNib(nibName: String? = nil, bundle: Bundle = .main) -> Self {
        let nibName = nibName ?? String(describing: Self.self)
        return Self(nibName: nibName, bundle: bundle)
    }
}
