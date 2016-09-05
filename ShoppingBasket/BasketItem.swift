//
//  BasketItem.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 8/31/16.
//
//

class BasketItem : Equatable {
    let foodItem : FoodItem
    var quantity : Int
    
    init(foodItem : FoodItem, quantity : Int = 1) {
        self.foodItem = foodItem
        self.quantity = quantity
    }
}

func == (lhs: BasketItem, rhs: BasketItem) -> Bool {
    return lhs.foodItem.id == rhs.foodItem.id
}