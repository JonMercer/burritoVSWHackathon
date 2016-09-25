//
//  CardView.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit
import Gifu

protocol CardViewDelegate {
    func dismissCard()
}

class CardView: UIView {

    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var redeemLaterButton: UIButton!
    @IBOutlet weak var mapsButton: RoundedButton!
    
    var gifView: AnimatableImageView!
    
    var item: Item!
    
    var showingQRCode: Bool = false
    
    var win: Bool = true
    
    var delegate: CardViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initializeView(){
        if let item = item {
            itemImage.image = item.image
            itemName.text = "\(item.name) From \(item.restaurant)"
        }
        mapsButton.hidden = false
        showResult()
    }
    
    func initializeScanView(hasScanned: Bool){
        if let item = item {
            itemImage.image = item.image
            itemName.text = "\(item.name) From \(item.restaurant)"
        }
        if hasScanned {
            resultsLabel.text = "Code Expired"
            resultsLabel.textColor = UIColor.redColor()
        } else {
            resultsLabel.text = "Redeem Successful!"
            resultsLabel.textColor = GREEN_COLOR
        }
    }
    
    func showResult(){
        if win {
            resultsLabel.text = "You Win!"
        } else {
            resultsLabel.text = "You Get A Discount!"
        }
    }
    
    class func instanceFromNib(frame: CGRect) -> CardView {
        let view = UINib(nibName: "CardView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CardView
        view.frame = frame
        return view
    }
    
    func showLoading(){
        resultsLabel.text = "Drawing..."
        
        itemImage.hidden = true
        itemName.hidden = true
        mapsButton.hidden = true
        
        gifView = AnimatableImageView(frame: itemImage.frame)
        gifView.bounds = itemImage.bounds
        gifView.animateWithImage(named: "dancingtaco.gif")
        self.addSubview(gifView)
    }
    
    func stopLoading(){
        itemImage.hidden = false
        itemName.hidden = false
        mapsButton.hidden = false
        
        gifView.removeFromSuperview()
        showResult()
        redeemLaterButton.hidden = false
    }
    
    func changeModes(){
        guard let item = item else { return }
        
        if showingQRCode {
            showingQRCode = false
            fadeInImage(itemImage, image: item.image)
        } else {
            showingQRCode = true
            fadeInImage(itemImage, image: generateQRCode())
        }
    }
    
    func fadeInImage(imageView: UIImageView, image: UIImage){
        UIView.animateWithDuration(0.3, animations: {
            imageView.alpha = 0.0
        })
        
        UIView.animateWithDuration(0.3, delay: 0.2, options: [], animations: {
                imageView.image = image
                imageView.alpha = 1.0
            }, completion: nil)
    }
    
    func generateQRCode() -> UIImage {
        let reqStr = "\(item.name) from \(item.restaurant)"
        let data = reqStr.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter!.setValue(data, forKey: "inputMessage")
        
        let qrImage:CIImage = filter!.outputImage!
        
        let scaleX = itemImage.frame.size.width / qrImage.extent.size.width
        let scaleY = itemImage.frame.size.height / qrImage.extent.size.height
        
        let resultQrImage = qrImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        return UIImage(CIImage: resultQrImage)
    }
    
    @IBAction func onRedeemLaterPressed(sender: AnyObject) {
        delegate?.dismissCard()
    }
    
    @IBAction func onMapButtonPressed(sender: AnyObject) {
        guard let item = item else { return }
        var restaurant_string = item.restaurant.stringByReplacingOccurrencesOfString(" ", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("&", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("?", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("=", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("!", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("@", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("$", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("%", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("^", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("*", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("'", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("`", withString: "+")
        restaurant_string = restaurant_string.stringByReplacingOccurrencesOfString("’", withString: "+")
        print(restaurant_string)
        UIApplication.sharedApplication().openURL(NSURL(string:
            "comgooglemaps://?q=\(restaurant_string)&center=45.6387,-122.6615&zoom=15&views=")!)
    }
}
