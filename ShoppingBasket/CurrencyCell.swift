//
//  CurrencyCell.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/5/16.
//
//

import UIKit

class CurrencyCell : UITableViewCell {
    
    @IBOutlet weak var currencyLabel : UILabel!
    @IBOutlet weak var currencyDescription : UILabel!
    
    func setupWithCurrency(currency : CurrencyType) {
        currencyLabel.text = currency.symbol
        currencyDescription.text = "\(String(currency.currencyDescription)) (\(String(currency.rawValue)))"
        accessoryType = (currency == ShoppingBasket.currency.type ? .Checkmark : .None)
    }
    
}
