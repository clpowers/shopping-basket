//
//  FoodItem.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 8/31/16.
//
//

import UIKit

class FoodItem : Equatable {
    let id : String
    let name : String
    let price : Double
    let unit : String
    private let imageName : String?
    
    var image : UIImage? {
        return UIImage(named: imageName ?? "missing")
    }

    init(id: String, name : String, price : Double = 0.0, priceUnit : String = "", imageName: String? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.unit = priceUnit
        self.imageName = imageName
    }
}

func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
    return lhs.id == rhs.id
}