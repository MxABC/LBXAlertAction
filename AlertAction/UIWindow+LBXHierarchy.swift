
import UIKit

/** @abstract UIWindow hierarchy category.  */
public extension UIWindow {

    /** @return Returns the current Top Most ViewController in hierarchy.   */
     public func topController()->UIViewController? {
        
        var topController = rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        
        return topController
    }
    
    /** @return Returns the topViewController in stack of topMostController.    */
    public func currentVC()->UIViewController? {
        
        var currentViewController = topController()
        
        while currentViewController != nil && currentViewController is UINavigationController && (currentViewController as! UINavigationController).topViewController != nil {
            currentViewController = (currentViewController as! UINavigationController).topViewController
        }

        return currentViewController
    }
}
