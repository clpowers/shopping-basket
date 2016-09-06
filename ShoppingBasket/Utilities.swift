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
    static func priceString(fromDouble double: Double) -> String {
        return "\(ShoppingBasket.currency.type.symbol) \(String(format:"%.2f", ShoppingBasket.currency.conversionFactor * double))"
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

extension NSData {
    func dataToJSON() -> AnyObject? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(self, options: .MutableContainers)
        } catch let error {
            print(error)
        }
        return nil
    }
}
