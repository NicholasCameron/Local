

import UIKit

class PushSegueWithRootReplacement: UIStoryboardSegue {
    
    override func perform() {
        destination.view.layoutIfNeeded()
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = self.destination
        }
    }
}
