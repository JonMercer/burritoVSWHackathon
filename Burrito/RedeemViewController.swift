//
//  RedeemViewController.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import Foundation
import UIKit
import expanding_collection

class RedeemViewController: ExpandingViewController {
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        itemSize = CGSize(width: 300, height: 300)
        super.viewDidLoad()
        
        // register cell
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: "ItemCell")
        
        items.append(Item(name: "Milkshake", restaurant: "Triple O's"))
        items.append(Item(name: "Milkshake", restaurant: "Triple O's"))
        items.append(Item(name: "Milkshake", restaurant: "Triple O's"))
        items.append(Item(name: "Milkshake", restaurant: "Triple O's"))
        collectionView?.reloadData()
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        let item = items[indexPath.row]
        cell.configureCell(item)
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ItemCell
        cell.onCellTapped()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }


}
