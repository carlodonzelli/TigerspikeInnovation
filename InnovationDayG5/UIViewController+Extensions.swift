//
//  UIViewController+Extensions.swift
//  InnovationDayG5
//
//  Created by James Pang on 24/11/2016.
//  Copyright © 2016 CarloDonzelli. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(with title: String = "Error", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.present(alert, animated: true, completion: nil)
    }
}
