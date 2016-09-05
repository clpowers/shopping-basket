//
//  ShoppingBasket.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/1/16.
//
//

class ShoppingBasket {
    
    static let sharedInstance = ShoppingBasket()
    
    var items = [BasketItem]()
    
    static func addBasketItem(item : BasketItem) -> BasketItem {
        let matching = ShoppingBasket.sharedInstance.items.filter({$0.foodItem == item.foodItem})
        if matching.count > 0 {
            matching[0].quantity = item.quantity
            return matching[0]
        } else {
            ShoppingBasket.sharedInstance.items.append(item)
            return item
        }
    }
    
    static func removeBasketItem(item: BasketItem) {
        item.quantity = 0
        ShoppingBasket.sharedInstance.items.removeObject(item)
    }
    
    static var basketTotal : Double {
        return ShoppingBasket.sharedInstance.items.map({$0.foodItem.price * Double($0.quantity)}).reduce(0, combine: {$0 + $1})
    }
}
