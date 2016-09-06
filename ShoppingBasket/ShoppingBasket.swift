//
//  ShoppingBasket.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/1/16.
//
//

protocol ShoppingBasketDelegate : class {
    func shoppingBasketDidUpdateItemCount(count: Int)
}

class ShoppingBasket {
    
    static let sharedInstance = ShoppingBasket()
    
    var items = [BasketItem]()
    weak var delegate : ShoppingBasketDelegate?
    
    static func addBasketItem(item : BasketItem) -> BasketItem {
        let matching = ShoppingBasket.sharedInstance.items.filter({$0.foodItem == item.foodItem})
        var basketItem = item
        if matching.count > 0 {
            matching[0].quantity = item.quantity
            basketItem = matching[0]
        } else {
            ShoppingBasket.sharedInstance.items.append(item)
        }
        
        ShoppingBasket.sharedInstance.delegate?.shoppingBasketDidUpdateItemCount(totalItemCount)
        return basketItem
    }
    
    static func removeBasketItem(item: BasketItem) {
        item.quantity = 0
        ShoppingBasket.sharedInstance.items.removeObject(item)
        ShoppingBasket.sharedInstance.delegate?.shoppingBasketDidUpdateItemCount(totalItemCount)
    }
    
    static var basketTotal : Double {
        return ShoppingBasket.sharedInstance.items.map({$0.foodItem.price * Double($0.quantity)}).reduce(0, combine: {$0 + $1})
    }
    
    static var totalItemCount : Int {
        return ShoppingBasket.sharedInstance.items.map({$0.quantity}).reduce(0, combine: {$0 + $1})
    }
}
