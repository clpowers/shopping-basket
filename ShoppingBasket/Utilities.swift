//
//  Utilities.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/1/16.
//
//

import Foundation
import UIKit

struct PriceFormatter {
    static func usdPriceString(fromDouble double: Double) -> String {
        return "$ \(String(format:"%.2f", double))"
    }
 
    // Maybe don't need this?
    static func doubleFromUSDString(usdPrice : String) -> Double {
        return Double(usdPrice.stringByReplacingOccurrencesOfString("$", withString: "")) ?? 0.0
    }
}

protocol Customizable {}

extension Customizable {
    func customize(@noescape customize: (Self) -> Void) -> Self {
        customize(self)
        return self
    }
}

extension UIView : Customizable {}

extension Array {
    mutating func removeObject<U: Equatable>(object: U) -> Bool {
        for (idx, objectToCompare) in self.enumerate() {
            if let to = objectToCompare as? U {
                if object == to {
                    self.removeAtIndex(idx)
                    return true
                }
            }
        }
        return false
    }
}
