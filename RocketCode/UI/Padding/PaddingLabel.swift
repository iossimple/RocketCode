//
//  PaddingLabel.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-13.
//

import UIKit
import EasyAnchor

public class PaddingLabel: UIView {
    public struct Padding {
        var top: CGFloat
        var left: CGFloat
        var bottom: CGFloat
        var right: CGFloat
        
        public static let zero = Padding(top: 0, left: 0, bottom: 0, right: 0)
        
        public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
            self.top = top
            self.left = left
            self.bottom = bottom
            self.right = right
        }
    }
    
    public var padding = Padding.zero {
        didSet {
            textLabel.anchor.find(.top)?.constant = padding.top
            textLabel.anchor.find(.left)?.constant = padding.left
            textLabel.anchor.find(.bottom)?.constant = 0-padding.bottom
            textLabel.anchor.find(.right)?.constant = 0-padding.right
        }
    }
    
    public var text = UILabel().text { didSet { textLabel.text = text } }
    
    public private(set) var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _setup()
    }
    
    private func _setup() {
        addSubview(textLabel)
        textLabel.pin(to: self, with: UIEdgeInsets(top: padding.top,
                                                   left: padding.left,
                                                   bottom: 0-padding.bottom,
                                                   right: 0-padding.right)
        )
    }
    
}
