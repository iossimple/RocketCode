import UIKit

public extension UIScreen {
    static var safeSize: CGSize {
        if #available(iOS 11.0, *) {
            guard let guide = UIApplication.shared.keyWindow?.safeAreaLayoutGuide
            else { return .zero }
            
            return guide.layoutFrame.size
        } else {
            guard let window = UIApplication.shared.keyWindow,
                  let rootVC = window.rootViewController
            else { return .zero }
            
            let screenSize = window.screen.bounds.size
            let topInset = rootVC.topLayoutGuide.length
            let bottomInset = rootVC.bottomLayoutGuide.length
            
            return CGSize(width: screenSize.width, height: screenSize.height - topInset - bottomInset)
        }
    }
}
