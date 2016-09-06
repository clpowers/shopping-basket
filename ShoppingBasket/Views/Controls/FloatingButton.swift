//
//  FloatingButton.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 8/31/16.
//
//

import UIKit

class FloatingButton : UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = frame.size.width / 2
        self.backgroundColor = UIColor.whiteColor()
    }
}