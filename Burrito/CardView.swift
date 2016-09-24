//
//  CardView.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    @IBAction func notificationButton(sender: AnyObject) {
        //temporary button
        var localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 20)
        localNotification.alertBody = "Raffle: Tripple O's Milkshake."
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

    }
    
    
    var item: Item!
    
    var showingQRCode: Bool = false
    
    class func instanceFromNib(frame: CGRect) -> CardView {
        let view = UINib(nibName: "CardView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CardView
        view.frame = frame
        return view
    }
    
    // When card is tapped, changeModes is called. If it is showingQRCode it will change to show item and vice versa
    func changeModes(){
        guard let item = item else { return }
        
        if showingQRCode {
            showingQRCode = false
            itemImage.image = item.image
            
        } else {
            showingQRCode = true
            itemImage.image = generateQRCode()
        }
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
}
