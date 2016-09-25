//
//  ItemCell.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit
import expanding_collection

class ItemCell: BasePageCollectionCell {

    var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
 
    class func instanceFromNib(frame: CGRect) -> ItemCell {
        let view = UINib(nibName: "ItemCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! ItemCell
        view.frame = frame
        return view
    }
    
    func configureCell(item: Item){
        
        cardView = CardView.instanceFromNib(CGRectMake(0, 0, 300, 300))
        cardView.item = item
        cardView.win = true
        cardView.initializeView()
        
        self.frontContainerView.addSubview(cardView)
    }
    
    func onCellTapped(){
        cardView.changeModes()
    }
}
