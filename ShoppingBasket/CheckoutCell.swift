//
//  CheckoutCell.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/5/16.
//
//

import UIKit

class CheckoutCell : UITableViewCell {
    
    @IBOutlet weak var quantity : UILabel?
    @IBOutlet weak var itemName : UILabel?
    @IBOutlet weak var itemImage : UIImageView?
    @IBOutlet weak var priceLabel : UILabel?
    
    func setupCell(basketItem : BasketItem) {
        quantity?.text = String(basketItem.quantity)
        itemName?.text = basketItem.foodItem.name
        itemImage?.image = basketItem.foodItem.image
        priceLabel?.text = PriceFormatter.usdPriceString(fromDouble: basketItem.foodItem.price * Double(basketItem.quantity))
    }
}
