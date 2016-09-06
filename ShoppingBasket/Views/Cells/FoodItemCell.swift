//
//  FoodItemCell.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 8/31/16.
//
//

import UIKit

class FoodItemCell : UICollectionViewCell {
    
    static let reuseId = "foodItem"
    
    @IBOutlet weak var itemName : UILabel?
    @IBOutlet weak var itemImage : UIImageView?
    @IBOutlet weak var priceLabel : UILabel?
    @IBOutlet weak var unitLabel : UILabel?
    @IBOutlet weak var quantityControl : QuantityControl?
    @IBOutlet weak var numberBadge : NumberBadge?
    
    @IBOutlet weak var addButton : UIButton?
    
    private var basketItem : BasketItem?
    
    func setupCell(basketItem : BasketItem) {
        self.basketItem = basketItem
        itemName?.text = basketItem.foodItem.name
        itemImage?.image = basketItem.foodItem.image
        priceLabel?.text = PriceFormatter.priceString(fromDouble: basketItem.foodItem.price)
        unitLabel?.text = basketItem.foodItem.unit.isEmpty ? "" : "per \(basketItem.foodItem.unit)"
        
        let selectedQuantity = ShoppingBasket.basketQuantityForFoodItem(basketItem.foodItem)
        basketItem.quantity = selectedQuantity
        numberBadge?.setBadgeNumber(selectedQuantity)
        quantityControl?.setupWithQuantity(selectedQuantity)
        BasketButtonState.Current.setupButton(addButton)
        
        setupUI()
    }
    
    func setupUI() {
        quantityControl?.customize{
            $0.delegate = self
        }
        
        priceLabel?.customize{
            $0.textColor = Style.Color.price
        }
        
        itemImage?.customize{
            $0.contentMode = .ScaleAspectFit
        }
        
        addButton?.customize{
            $0.backgroundColor = Style.Color.primary
            $0.layer.cornerRadius = 3
            $0.addTarget(self, action: #selector(addToBasketPressed), forControlEvents: .TouchUpInside)
        }
        
        BasketButtonState.Current.setupButton(addButton)
        
        
        quantityControl?.decrementButton?.customize{
            $0.layer.cornerRadius = 15
            $0.layer.borderColor = tintColor.colorWithAlphaComponent(0.7).CGColor
            $0.layer.borderWidth = 1
        }
        quantityControl?.incrementButton?.customize{
            $0.layer.cornerRadius = 15
            $0.layer.borderColor = tintColor.colorWithAlphaComponent(0.7).CGColor
            $0.layer.borderWidth = 1
        }
    }
    
    @IBAction func addToBasketPressed() {
        guard let item = basketItem else {return}
        guard let quantity = quantityControl?.quantity else {return}
        guard quantity != item.quantity else {return} // Only update if the quantity has changed
        
        if quantity == 0 {
            ShoppingBasket.removeBasketItem(item)
        } else {
            self.basketItem = ShoppingBasket.addBasketItem(BasketItem(foodItem: item.foodItem, quantity: quantity))
        }
        numberBadge?.setBadgeNumber(basketItem?.quantity ?? 0)
        BasketButtonState.Current.setupButton(addButton)
    }
}

extension FoodItemCell : QuantityControlDelegate {
    func quantityHasBeenUpdated(quantity: Int) {
        var buttonState : BasketButtonState?
        if basketItem?.quantity == quantity {
            buttonState = .Current
        } else if basketItem?.quantity == 0 && quantity > 0 {
            buttonState = .Add
        } else {
            buttonState = .Update
        }
        buttonState?.setupButton(addButton)
    }
}

extension FoodItemCell {
    enum BasketButtonState {
        case Add
        case Update
        case Current
        
        func setupButton(button : UIButton?) {
            var title : String = ""
            var backgroundColor = UIColor.clearColor(), textColor = UIColor.clearColor()
            
            switch self {
            case .Add:
                title = "Add to Basket"
                backgroundColor = Style.Color.primary
                textColor = Style.Color.lightText
            case .Update:
                title = "Update Basket"
                backgroundColor = Style.Color.primary
                textColor = Style.Color.lightText
            case .Current:
                title = "In Basket"
                backgroundColor = Style.Color.lightGray
                textColor = Style.Color.gray
            }
            UIView.performWithoutAnimation({
                button?.setTitle(title, forState: .Normal)
                button?.backgroundColor = backgroundColor
                button?.setTitleColor(textColor, forState: .Normal)
                button?.layoutIfNeeded()
            })
            
        }
    }
}


