import UIKit

public extension UIStoryboard {
    
    /// Instantiates and returns the view controller with the specified identifier and type.
    /// If identifier is not specified then it uses type name as an identifier.
    ///
    /// - Parameters:
    ///   - type: Concrete type of a view controller to instantiate
    ///   - identifier: Identifier string that uniquely identifies the view controller in the storyboard
    ///                 file - provide if different from type name
    ///
    /// - Returns: The view controller corresponding to the specified type and identifier string.
    ///            If no view controller is associated with the string or type, this method throws an exception.
    static func instantiateViewController<T: UIViewController>(
        ofType type: T.Type,
        withIdentifier identifier: String? = nil,
        inStoryboardNamed storyboardName: String = "Main",
        bundle: Bundle = .main
    ) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let identifier = identifier ?? String(describing: T.self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
