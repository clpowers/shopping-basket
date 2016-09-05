//
//  FoodCategory.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 8/31/16.
//
//

class FoodCategory {
    let name : String
    var items : [BasketItem]
    
    init(name : String, foodItems : [FoodItem] = []) {
        self.name = name
        self.items = foodItems.map{BasketItem(foodItem: $0, quantity: 0)}
    }
}