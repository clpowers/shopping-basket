//
//  Style.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 8/31/16.
//
//

import UIKit

enum Style {
    
    enum Color {
        static var primary : UIColor {
            return UIColor(red: 199/255.0, green: 25/255.0, blue: 36/255.0, alpha: 1.0)
        }
        
        static var text : UIColor {
            return UIColor.blackColor().colorWithAlphaComponent(0.7)
        }
        
        static var lightText : UIColor {
            return UIColor.whiteColor()
        }
        
        static var price : UIColor {
            return UIColor(red: 29/255.0, green: 130/255.0, blue: 55/255.0, alpha: 0.8)
        }
        
        static var accent : UIColor {
            return UIColor.blueColor()
        }
        
        static var gray : UIColor {
            return UIColor.blackColor().colorWithAlphaComponent(0.25)
        }
        
        static var lightGray : UIColor {
            return UIColor.blackColor().colorWithAlphaComponent(0.07)
        }
    }
    
}
