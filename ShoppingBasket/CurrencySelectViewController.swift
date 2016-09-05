//
//  CurrencySelectViewController.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 9/5/16.
//
//

import UIKit

class CurrencySelectViewController : UIViewController {
    
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.customize{
            $0.layer.cornerRadius = 4
        }
        tableView.customize{
            $0.layer.cornerRadius = 4
        }
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCloseView)))
    }
    
    func didTapCloseView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension CurrencySelectViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrencyManager.numberOfSupportedCurrencies
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("currencyCell", forIndexPath: indexPath) as! CurrencyCell
        cell.accessoryType = .Checkmark
        return cell
    }
}

extension CurrencySelectViewController : UITableViewDelegate {
    
}
