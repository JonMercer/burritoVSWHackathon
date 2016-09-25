//
//  Item.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import Foundation
import UIKit

class Item {
    
    private var _name: String!
    private var _restaurant: String!
    private var _image: UIImage!
    
    var name: String! {
        return _name
    }
    
    var restaurant: String! {
        return _restaurant
    }
    
    var image: UIImage! {
        return _image
    }
    
    init(name: String, restaurant: String, image: UIImage){
        _name = name
        _restaurant = restaurant
        _image = image
    }
}
