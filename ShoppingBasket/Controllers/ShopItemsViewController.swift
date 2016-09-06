//
//  ShopItemsViewController.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 8/31/16.
//
//

import UIKit

class ShopItemsViewController: UIViewController {

    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var numberBadge : NumberBadge!
    
    @IBOutlet weak var checkoutButton : UIButton?
    
    let groceryOptions = [dairy, vegetables]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUICustomizations()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if collectionView.contentSize.height + 50 < collectionView.frame.size.height {
            checkoutButton?.hidden = false
        }
    }
    
    func setupUICustomizations() {
        checkoutButton?.customize{
            $0.backgroundColor = Style.Color.primary
            $0.titleLabel?.textColor = Style.Color.lightText
        }
        numberBadge.setBadgeNumber(ShoppingBasket.totalItemCount)
    }
}

extension ShopItemsViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return groceryOptions.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groceryOptions[section].items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(FoodItemCell.reuseId, forIndexPath: indexPath) as! FoodItemCell
        cell.layer.cornerRadius = 4
        cell.setupCell(groceryOptions[indexPath.section].items[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader{
            guard let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: CategoryReusableView.reuseId, forIndexPath: indexPath) as? CategoryReusableView else {return UICollectionReusableView()}
            headerView.categoryLabel?.text = groceryOptions[indexPath.section].name
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension ShopItemsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake((collectionView.frame.width - 24) / 2, 192)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let padding : CGFloat = 8.0
        if groceryOptions[section].items.count == 1 {
            // Center when there is only one item
            return UIEdgeInsetsMake(padding, collectionView.frame.width / 4, padding, collectionView.frame.width / 4)
        } else {
            // More than one, center 2 items
            return UIEdgeInsetsMake(padding, padding, padding, padding)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8
    }
}
