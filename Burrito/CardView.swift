//
//  CardView.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    var showingQRCode: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
     
        initializeSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }

    func initializeSubviews(){
        let view = NSBundle.mainBundle().loadNibNamed("CardView", owner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        
        self.addSubview(view)
    }
    
    // When card is tapped, changeModes is called. If it is showingQRCode it will change to show item and vice versa
    func changeModes(){
        if showingQRCode {
            showingQRCode = false
            
            
        } else {
            showingQRCode = true
            
        }
    }
}
