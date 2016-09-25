//
//  NotificationsManager.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import Foundation
import UIKit

class NotificationsManager {
    static let sharedInstance = NotificationsManager()
    private init() {}
    
    func presentCardView(tabBarController: UITabBarController){
        if let VC = tabBarController.viewControllers![VC_INDEX] as? ViewController {
            VC.showItem()
        }
    }
}