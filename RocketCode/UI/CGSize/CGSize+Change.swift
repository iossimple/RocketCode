//
//  CGSize+Change.swift
//  sample-id
//
//  Created by Viet Nguyen Tran on 2021-06-13.
//

import CoreGraphics

public extension CGSize {
    func change(deltaWidth: CGFloat, deltaheight: CGFloat) -> CGSize {
        return CGSize(width: width + deltaheight, height: height + deltaheight)
    }
}
