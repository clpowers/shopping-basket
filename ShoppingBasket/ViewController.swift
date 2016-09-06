//
//  ViewController.swift
//  ShoppingBasket
//
//  Created by Chelsea Powers on 8/31/16.
//
//

import UIKit

let dairy = FoodCategory(name: "Dairy & Eggs", foodItems: [FoodItem(id: "1", name: "Milk", price: 1.3, priceUnit: "bottle", imageName: "milk"), FoodItem(id: "2", name: "Eggs", price: 2.1, priceUnit: "dozen", imageName: "eggs")])
let vegetables = FoodCategory(name: "Vegetables & Beans", foodItems: [FoodItem(id: "3", name: "Peas", price: 0.95, priceUnit: "bag", imageName: "peas"), FoodItem(id: "4", name: "Beans", price: 0.73, priceUnit: "can", imageName: "beans")])

class ViewController: UIViewController {

    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var numberBadge : NumberBadge!
    
    @IBOutlet weak var checkoutButton : UIButton?
    
    let groceryOptions = [dairy, vegetables]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUICustomizations()
    }
    
    func setupUICustomizations() {
        checkoutButton?.customize{
            $0.backgroundColor = Style.Color.primary
            $0.titleLabel?.textColor = Style.Color.lightText
        }
        numberBadge.setBadgeNumber(ShoppingBasket.totalItemCount)
    }
}

extension ViewController : UICollectionViewDelegate {
    
}

extension ViewController : UICollectionViewDataSource {
    
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

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake((collectionView.frame.width - 24) / 2, 192)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if groceryOptions[section].items.count == 1 {
            // Center when there is only one item
            return UIEdgeInsetsMake(8, collectionView.frame.width / 4, 8, collectionView.frame.width / 4)
        } else {
            // More than one, center 2 items
            return UIEdgeInsetsMake(8, 8, 8, 8)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8
    }
}
