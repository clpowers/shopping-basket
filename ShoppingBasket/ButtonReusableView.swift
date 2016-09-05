//
//  ButtonReusableView.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/1/16.
//
//

import UIKit

class ButtonReusableView : UICollectionReusableView {
    
    static let reuseId = "buttonFooter"
    
    @IBOutlet weak var button : UIButton?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        button?.customize{
            $0.backgroundColor = Style.Color.primary
            $0.titleLabel?.textColor = Style.Color.lightText
        }
    }
}
