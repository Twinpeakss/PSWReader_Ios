//
//  AlertService.swift
//  PSWreader
//
//  Created by projekt sz on 13.09.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    func alert(message: String) -> UIAlertController! {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        return alert
    }
}
