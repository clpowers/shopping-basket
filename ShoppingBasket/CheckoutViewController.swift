//
//  CheckoutViewController.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/5/16.
//
//

import UIKit

class CheckoutViewController : UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var basketTotal : UILabel!
    @IBOutlet weak var currencyButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateForCurrencyChange()
    }
    
    func updateForCurrencyChange() {
        tableView.reloadData()
        currencyButton.title = "\(ShoppingBasket.currency.type.symbol) (\(ShoppingBasket.currency.type.rawValue))"
        basketTotal.text = PriceFormatter.priceString(fromDouble: ShoppingBasket.basketTotal)
    }
    
    @IBAction func backButtonPressed() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? CurrencySelectViewController {
            vc.delegate = self
        }
    }
}

extension CheckoutViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingBasket.uniqueItems
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("checkoutCell", forIndexPath: indexPath) as! CheckoutCell
        cell.setupCell(ShoppingBasket.items[indexPath.row])
        return cell
    }
}

extension CheckoutViewController : CurrencySelectDelegate {
    
    func currencyHasBeenUpdated() {
        updateForCurrencyChange()
    }
}