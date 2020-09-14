import Foundation
import UIKit

class AlertService {
    func alert(message: String) -> UIAlertController! {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        return alert
    }
}
