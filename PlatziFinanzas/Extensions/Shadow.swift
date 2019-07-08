//
//  Shadow.swift
//  PlatziFinanzas
//
//  Created by Andres Silva on 11/14/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import UIKit

extension UIView {
    var borderUIColor: UIColor {
        get {
            guard let color = layer.borderColor else {
                return UIColor.black
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
