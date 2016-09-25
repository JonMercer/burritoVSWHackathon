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
    
    let CHANGE_MODE_DELAY = 2.0
    let LOADING_DELAY = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.tabBarController?.tabBar.tintColor = BLUE_COLOR
        //self.tabBarController?.tabBar.backgroundColor = UIColor.redColor()
        //self.tabBarController?.tabBar.translucent = false
    }

    @IBAction func onTestButtonTapped(sender: AnyObject) {
        showItem()
    }
    
    @IBAction func onNotificationButtonTapped(sender: AnyObject) {
        sendLocalNotification()
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
        
        cardView.showLoading()
        
        delay(LOADING_DELAY){
            self.cardView.stopLoading()
            delay(self.CHANGE_MODE_DELAY){
                if !self.cardView.showingQRCode {
                    self.cardView.changeModes()
                }
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
