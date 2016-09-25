//
//  BorderButton.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-25.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {


    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 4
        self.layer.borderWidth = CGFloat(1.2)
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

}
