//
//  NumberBadge.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/1/16.
//
//

import UIKit

class NumberBadge : UILabel {
    
    func setBadgeNumber(number : Int) {
        hidden = number == 0
        text = String(number)
        layer.cornerRadius = frame.size.width / 2
        backgroundColor = Style.Color.primary
        textColor = Style.Color.lightText
        clipsToBounds = true
    }
    
}
