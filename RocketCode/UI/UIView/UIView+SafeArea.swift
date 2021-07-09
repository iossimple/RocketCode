import UIKit

public extension UIView {
    var safeSize: CGSize {
        return safeBounds.size
    }
    
    var safeBounds: CGRect {
        // TOOD: consider safeAreaLayoutGuide.layoutFrame
        return bounds.inset(by: safeAreaInsets)
    }
}
