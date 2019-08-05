//
//  Numeric.swift
//  DemoApp
//
//  Created by julio vargas bautista on 7/11/19.
//  Copyright © 2019 Platzi. All rights reserved.
//

import Foundation

extension Numeric {
    func currency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        guard let formatted = formatter.string(from: self as! NSNumber) else{
            return "\(self)"
        }
        return formatted
    }
}
