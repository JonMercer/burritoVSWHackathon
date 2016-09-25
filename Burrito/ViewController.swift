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
    @IBOutlet weak var timerLabel: UILabel!
    var timer = NSTimer()
    var minutesLabel = ""
    var secondsLabel = ""
    var secondsLeft = 6 // 40min

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimerLabel()
        let one:NSTimeInterval = 1.0
        timer = NSTimer.scheduledTimerWithTimeInterval(one, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    func timerAction() {
        
        if(secondsLeft > 0) {
            secondsLeft -= 1
        } else {
            timer.invalidate()
        }
        
        updateTimerLabel()
        
    }
    
    func updateTimerLabel() {
        minutesLabel = String(format: "%02d",(secondsLeft / 60) % 60)
        secondsLabel = String(format: "%02d", secondsLeft % 60)
        timerLabel.text = "\(minutesLabel)" + ":" + "\(secondsLabel)"
    }

    @IBAction func onTestButtonTapped(sender: AnyObject) {
        let item = Item(name: "Triple O's Milkshake", restaurant: "Triple O's")
        cardView = CardView.instanceFromNib(CGRectMake(0, 0, 300, 300))
        cardView.item = item
        
        let popupConfig = STZPopupViewConfig()
        popupConfig.dismissTouchBackground = true
        popupConfig.cornerRadius = 5.0
        
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.onCardTapped(_:))))
        presentPopupView(cardView, config:  popupConfig)
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
