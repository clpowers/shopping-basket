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
    
    private static let sharedInstance = ShoppingBasket()
    
    var items = [BasketItem]()
    weak var delegate : ShoppingBasketDelegate?
    var currency : Currency = Currency(conversionFactor: 1.0, type: .USD)
    
    // MARK: - Static Functions
    
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
    
    static func updateCurrency(currency: Currency) {
        ShoppingBasket.sharedInstance.currency = currency
    }
    
    static func setDelegate(delegate : ShoppingBasketDelegate?) {
        ShoppingBasket.sharedInstance.delegate = delegate
    }
    
    // MARK: - Static Vars
    
    static var items : [BasketItem] {
        return ShoppingBasket.sharedInstance.items
    }
    
    static var basketTotal : Double {
        return ShoppingBasket.sharedInstance.items.map({$0.foodItem.price * Double($0.quantity)}).reduce(0, combine: {$0 + $1})
    }
    
    static var totalItemCount : Int {
        return ShoppingBasket.sharedInstance.items.map({$0.quantity}).reduce(0, combine: {$0 + $1})
    }
    
    static var uniqueItems : Int {
        return ShoppingBasket.sharedInstance.items.count
    }
    
    static var currency : Currency {
        return ShoppingBasket.sharedInstance.currency
    }
}
