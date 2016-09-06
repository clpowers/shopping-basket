//
//  CurrencySelectViewController.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/5/16.
//
//

import UIKit

protocol CurrencySelectDelegate : class {
    func currencyHasBeenUpdated()
}

class CurrencySelectViewController : UIViewController {
    
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var tableView : UITableView!
    
    weak var delegate : CurrencySelectDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let roundedCornerRadius : CGFloat = 6
        mainView.customize{
            $0.layer.cornerRadius = roundedCornerRadius
        }
        tableView.customize{
            $0.layer.cornerRadius = roundedCornerRadius
        }
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCloseView)))
    }
    
    func didTapCloseView(tapGesture : UITapGestureRecognizer) {
        if !CGRectContainsPoint(mainView.frame, tapGesture.locationInView(view)) {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            guard let indexPath = tableView.indexPathForRowAtPoint(tapGesture.locationInView(tableView)) else {return}
            print(indexPath.row)
            tableView(tableView, didSelectRowAtIndexPath: indexPath)
        }
    }
}

extension CurrencySelectViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrencyType.supportedTypes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("currencyCell", forIndexPath: indexPath) as! CurrencyCell
        cell.setupWithCurrency(CurrencyType.supportedTypes[indexPath.row])
        return cell
    }
}

extension CurrencySelectViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let selectedType = CurrencyType.supportedTypes[indexPath.row]
        guard selectedType != ShoppingBasket.currency.type else {
            // If didn't select a new currency
            dismissViewControllerAnimated(true, completion: nil)
            return
        }
        guard selectedType != .USD else {
            // Don't need to make a service call for USD conversion
            ShoppingBasket.updateCurrency(Currency(conversionFactor: 1.0, type: .USD))
            dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        CurrencyManager.getCurrencyExchangeRateForType(selectedType, completion: { [weak self] currency in
            // Save to shopping basket
            guard let currency = currency else {
                // Conversion wasn't retrieved. Should display error message and dismiss (keeping same currency)
                self?.dismissViewControllerAnimated(true, completion: nil); return;
            }
            ShoppingBasket.updateCurrency(currency)
            self?.delegate?.currencyHasBeenUpdated()
            self?.dismissViewControllerAnimated(true, completion: nil)
        })
        
    }
    
}
