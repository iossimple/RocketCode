//
//  UIView+Instantiate.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-12.
//

import UIKit

public extension UIView {
    static func instantiateFromNib(
        nibName: String? = nil,
        owner: Any? = nil,
        bundle: Bundle = .main
    ) -> Self {
        let nibName = nibName ?? String(describing: Self.self)
        return UINib.instantiateView(
            ofType: Self.self,
            fromNibNamed: nibName,
            owner: owner,
            bundle: bundle)
    }
}
