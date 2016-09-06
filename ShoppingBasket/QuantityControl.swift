//
//  QuantityControl.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/1/16.
//
//

import UIKit

protocol QuantityControlDelegate : class {
    func quantityHasBeenUpdated(quantity : Int)
}

class QuantityControl : UIStackView {
    
    @IBOutlet weak var decrementButton : UIButton?
    @IBOutlet weak var quantityLabel : UILabel?
    @IBOutlet weak var incrementButton : UIButton?
    
    weak var delegate : QuantityControlDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        quantityLabel?.customize{
            $0.text = "0"
        }
    }
    
    private(set) var quantity : Int = 0 {
        didSet {
            quantityLabel?.text = String(quantity)
        }
    }
    
    @IBAction func incrementTapped() {
        quantity = min(quantity + 1, 99)
        delegate?.quantityHasBeenUpdated(quantity)
    }
    
    @IBAction func decrementTapped() {
        quantity = max(quantity - 1, 0)
        delegate?.quantityHasBeenUpdated(quantity)
    }
    
    func resetToZero() {
        quantity = 0
    }
}