//
//  EmptyView.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-23.
//

import UIKit

public class EmptyView: UIView {

    public static func instance() -> EmptyView {
        return UINib.instantiateView(ofType: EmptyView.self, bundle: Bundle(for: Self.self))
    }

    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var descriptionLabel: UILabel!
}
