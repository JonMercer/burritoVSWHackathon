//
//  General.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import Foundation
import UIKit

let VC_INDEX = 0
let BLUE_COLOR = UIColor(red: 67.0/255.0, green: 125.0/255.0, blue: 234.0/255.0, alpha: 1.0)

func bounceView(view: UIView, amount: CGFloat){
    UIView.animateWithDuration(0.1, delay: 0.0, options: [], animations: {
        view.transform = CGAffineTransformMakeScale(amount, amount)
        }, completion: {completed in
            UIView.animateWithDuration(0.1, delay: 0.0, options: [], animations: {
                view.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: {completed in })
    })
}

func delay(amount: Double, completion:()->()){
    let delay = amount * Double(NSEC_PER_SEC)
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(time, dispatch_get_main_queue()) {
        completion()
    }
}

func sendLocalNotification(){
    var localNotification = UILocalNotification()
    localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
    localNotification.alertBody = "Giveaway: Triple O's Milkshake."
    localNotification.timeZone = NSTimeZone.defaultTimeZone()
    localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
    
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
}