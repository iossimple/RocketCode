import UIKit

public extension UIView {
    var safeSize: CGSize {
        return safeBounds.size
    }
    
    var safeBounds: CGRect {
        return bounds.inset(by: safeAreaInsets)
    }
}
