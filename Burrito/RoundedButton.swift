//
//  RoundedButton.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
}
