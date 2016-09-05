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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketTotal.text = PriceFormatter.usdPriceString(fromDouble: ShoppingBasket.basketTotal)
    }
    
    @IBAction func backButtonPressed() {
        navigationController?.popViewControllerAnimated(true)
    }

    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let currency = segue.destinationViewController as? CurrencySelectViewController, let currencyPopover = segue.destinationViewController.popoverPresentationController {
            currency.modalPresentationStyle = .Popover
            currency.preferredContentSize = CGSizeMake(300, 300)
            currencyPopover.delegate = self
            currencyPopover.sourceView = self.view
        }
    }*/
}

extension CheckoutViewController : UITableViewDelegate {
    
}

extension CheckoutViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingBasket.sharedInstance.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("checkoutCell", forIndexPath: indexPath) as! CheckoutCell
        cell.setupCell(ShoppingBasket.sharedInstance.items[indexPath.row])
        return cell
    }
}