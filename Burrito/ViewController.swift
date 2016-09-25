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
    
    let CHANGE_MODE_DELAY: Int64 = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func onTestButtonTapped(sender: AnyObject) {
        showItem()
    }
    
    func showItem(){
        let item = Item(name: "Milkshake", restaurant: "Triple O's")
        cardView = CardView.instanceFromNib(CGRectMake(0, 0, 300, 300))
        cardView.item = item
        
        let popupConfig = STZPopupViewConfig()
        popupConfig.dismissTouchBackground = true
        popupConfig.cornerRadius = 5.0
        
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.onCardTapped(_:))))
        presentPopupView(cardView, config:  popupConfig)
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), CHANGE_MODE_DELAY * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            if !self.cardView.showingQRCode {
                self.cardView.changeModes()
            }
        }
    }
    
    func onCardTapped(sender: AnyObject){
        cardView.changeModes()
    }
    
    @IBAction func onRestaurantButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("vcToLoginVC", sender: nil)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
