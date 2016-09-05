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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addButton?.customize{
            $0.backgroundColor = Style.Color.primary
            $0.addTarget(self, action: Selector(addToBasketPressed()), forControlEvents: .TouchUpInside)
        }
    }
    
    func setupCell(basketItem : BasketItem) {
        self.basketItem = basketItem
        itemName?.text = basketItem.foodItem.name
        itemImage?.image = basketItem.foodItem.image
        priceLabel?.text = PriceFormatter.usdPriceString(fromDouble: basketItem.foodItem.price)
        unitLabel?.text = basketItem.foodItem.unit.isEmpty ? "" : "per \(basketItem.foodItem.unit)"
        numberBadge?.setBadgeNumber(0)
        
        quantityControl?.delegate = self
        
        priceLabel?.customize{
            $0.textColor = Style.Color.price
        }
        
        itemImage?.customize{
            $0.contentMode = .ScaleAspectFit
        }
        
        if quantityControl?.quantity == 0 {
            addButton?.hidden = true
        }
    }
    
    @IBAction func addToBasketPressed() {
        
        guard let item = basketItem else {return}
        guard let quantity = quantityControl?.quantity else {return}
        if quantity == 0 {
            ShoppingBasket.removeBasketItem(item)
        } else {
            self.basketItem = ShoppingBasket.addBasketItem(BasketItem(foodItem: item.foodItem, quantity: quantity))
        }
        numberBadge?.setBadgeNumber(basketItem?.quantity ?? 0)
        addButton?.hidden = true
    }
}

extension FoodItemCell : QuantityControlDelegate {
    func quantityHasBeenUpdated(quantity: Int) {
        if basketItem?.quantity == 0 && quantity > 0 {
            UIView.performWithoutAnimation({ [weak self] in
                self?.addButton?.setTitle("Add to Basket", forState: .Normal)
                self?.addButton?.layoutIfNeeded()
                })
            addButton?.hidden = false
        } else if basketItem?.quantity == quantity {
            addButton?.hidden = true
        } else {
            UIView.performWithoutAnimation({ [weak self] in
                self?.addButton?.setTitle("Update Basket", forState: .Normal)
                self?.addButton?.layoutIfNeeded()
            })
            addButton?.hidden = false
        }
    }
}
