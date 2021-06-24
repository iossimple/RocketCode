import UIKit

public extension UINib {
    static func instantiateView<T: UIView>(
        ofType type: T.Type,
        fromNibNamed nibName: String? = nil,
        owner: Any? = nil,
        bundle: Bundle = .main
    ) -> T {
        let nibName = nibName ?? String(describing: T.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: owner, options: nil).first as! T
    }
    
    static func instantiateViewController<T: UIViewController>(
        ofType type: T.Type,
        fromNibNamed nibName: String? = nil,
        bundle: Bundle = .main
    ) -> T {
        let nibName = nibName ?? String(describing: T.self)
        return T(nibName: nibName, bundle: bundle)
    }
    
    static func instantiateArray<T>(
        ofType type: T.Type,
        fromNibNamed nibName: String? = nil,
        bundle: Bundle = .main,
        owner: Any? = nil
    ) -> [Any] {
        let nibName = nibName ?? String(describing: T.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: owner, options: nil)
    }
}
