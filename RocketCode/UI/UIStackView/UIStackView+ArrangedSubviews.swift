//
//  UIStackView+ArrangedSubviews.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-12.
//

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func removeArrangedSubviewSafely(_ view: UIView) {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
    }
    
    func removeAllArrangedSubviewsSafely() {
        arrangedSubviews.forEach { removeArrangedSubviewSafely($0) }
    }
}
