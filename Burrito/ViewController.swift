//
//  ViewController.swift
//  Burrito
//
//  Created by Odin on 2016-09-23.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit
import STZPopupView

class ViewController: UIViewController {
    
    var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func onTestButtonTapped(sender: AnyObject) {
        cardView = CardView(frame: CGRectMake(0, 0, 300, 300))
        
        let popupConfig = STZPopupViewConfig()
        popupConfig.dismissTouchBackground = true
        popupConfig.cornerRadius = 5.0
        
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.onCardTapped(_:))))
        presentPopupView(cardView, config:  popupConfig)
    }
    
    func onCardTapped(sender: AnyObject){
        
    }
}

