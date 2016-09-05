//
//  CurrencyManager.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/5/16.
//
//

import Foundation

enum SupportedCurrencies : String {
    case USD = "US Dollar"
    case EUR = "Euro"
    case AUD = "Austrailian Dollar"
    case CAD = "Canadian Dollar"
    case GBP = "British Pound Sterling"
    case MXN = "Mexican Peso"
    
    
}

class CurrencyManager {
    
    private static let API_KEY = "b122457ada2113528de1800e0d443c64"
    private static let BASE_URL = "http://apilayer.net/api/"
    
    static func getCurrencyExchangeRates() {
        let sessionTask = NSURLSession().dataTaskWithURL(NSURL(string: "\(BASE_URL)live?access_key=\(API_KEY)&format=1")!)
    }
    
    static var numberOfSupportedCurrencies : Int {
        return 6
    }
}


