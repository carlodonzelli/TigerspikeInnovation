//
//  UIImage+Extension.swift
//  InnovationDayG5
//
//  Created by Carlo Donzelli on 25/11/16.
//  Copyright © 2016 CarloDonzelli. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func withColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
