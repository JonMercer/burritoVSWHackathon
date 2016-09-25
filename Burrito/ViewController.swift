//
//  ViewController.swift
//  Burrito
//
//  Created by Odin on 2016-09-23.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit
import STZPopupView

class ViewController: UIViewController, CardViewDelegate {
    
    var cardView: CardView!
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    var timer = NSTimer()
    var secondsLeft = 60*40 // 40min
    
    let CHANGE_MODE_DELAY = 2.0
    let LOADING_DELAY = 2.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.backgroundImage = UIImage.fromColor(DARK_BLUR_COLOR)
        //self.tabBarController?.tabBar.backgroundColor = UIColor.redColor()
        //self.tabBarController?.tabBar.translucent = false
        
        updateTimerLabel()
        let one:NSTimeInterval = 1.0
        timer = NSTimer.scheduledTimerWithTimeInterval(one, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }

    @IBAction func onTestButtonTapped(sender: AnyObject) {
        showItem()
    }
    
    @IBAction func onNotificationButtonTapped(sender: AnyObject) {
        sendLocalNotification()
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
        minutesLabel.text = String(format: "%02d",(secondsLeft / 60) % 60)
        secondsLabel.text = String(format: "%02d", secondsLeft % 60)
    }
    
    func showItem(){
        let item = Item(name: "15% Off", restaurant: "Deer Island Bakery", image: UIImage(named: "deerislandwin")!)
        cardView = CardView.instanceFromNib(CGRectMake(0, 0, 300, 300))
        cardView.item = item
        cardView.win = false
        cardView.initializeView()
        cardView.delegate = self
        
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
    
    func dismissCard() {
        dismissPopupView()
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

extension UIImage {
    static func fromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
