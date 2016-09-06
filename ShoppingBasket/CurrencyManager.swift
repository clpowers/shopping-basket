//
//  CurrencyManager.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/5/16.
//
//

import Foundation

enum CurrencyType : String {
    case USD
    case EUR
    case AUD
    case CAD
    case GBP
    case MXN
    
    static var supportedTypes : [CurrencyType] = [.USD, .EUR, .AUD, .CAD, .GBP, .MXN]
    
    var symbol : String {
        switch self {
        case .USD, .AUD, .CAD, .MXN:
            return "$"
        case .EUR: return "€"
        case .GBP: return "£"
        }
    }
    
    var currencyDescription : String {
        switch self {
        case .USD: return "US Dollar"
        case .AUD: return "Austrailian Dollar"
        case .CAD: return "Canadian Dollar"
        case .MXN: return "Mexican Peso"
        case .EUR: return "Euro"
        case .GBP: return "British Pound Sterling"
        }
    }
}

struct Currency {
    var conversionFactor : Double
    var type : CurrencyType
}

class CurrencyManager {
    
    private static let API_KEY = "b122457ada2113528de1800e0d443c64"
    private static let BASE_URL = "http://apilayer.net/api/"
    
    static func getCurrencyExchangeRateForType(type : CurrencyType, completion:(Currency?)->(Void)) {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithURL(NSURL(string: "\(BASE_URL)live?access_key=\(API_KEY)&currencies=\(type.rawValue)&format=1")!) { data, response, error in
            
            guard let data = data else {completion(nil); return;}
            let json = data.dataToJSON()
            if let quotes = json?["quotes"] as? [String : Double], let conversion = quotes["USD\(type.rawValue)"] {
                completion(Currency(conversionFactor: conversion, type: type))
            } else {
                completion(nil);
            }
        }
        task.resume()
    }
}


