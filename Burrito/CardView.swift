//
//  CardView.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit
import Gifu

class CardView: UIView {

    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    var gifView: AnimatableImageView!
    
    var item: Item!
    
    var showingQRCode: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instanceFromNib(frame: CGRect) -> CardView {
        let view = UINib(nibName: "CardView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CardView
        view.frame = frame
        return view
    }
    
    func showLoading(){
        gifView = AnimatableImageView(frame: itemImage.frame)
        gifView.bounds = itemImage.bounds
        gifView.animateWithImage(named: "dancingtaco.gif")
        self.addSubview(gifView)
    }
    
    func stopLoading(){
        gifView.removeFromSuperview()
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
}
