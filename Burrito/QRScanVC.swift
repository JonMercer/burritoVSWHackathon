//
//  QRScanVC.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit
import AVFoundation
import STZPopupView

class QRScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scannedLabel: UILabel!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    var numberScanned: Int = 0
    var scannedBarcodes: [AVMetadataMachineReadableCodeObject] = []
    
    var flag: Bool = true
    var hasScanned: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beginCapture()
    }
    
    func beginCapture(){
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
        // as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        var error: NSError?
        do {
            let input: AnyObject! = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            // Set the input device on the capture session.
            captureSession?.addInput(input as! AVCaptureInput)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.bounds = captureView.bounds
            videoPreviewLayer?.frame = captureView.frame
            view.layer.addSublayer(videoPreviewLayer!)

            // Start video capture.
            captureSession?.startRunning()
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
            qrCodeFrameView?.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView!)
            view.bringSubviewToFront(qrCodeFrameView!)
            
        } catch {
            return
        }

    }

    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            messageLabel.text = "No QR code detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            qrCodeFrameView?.center.y += 40
            
            if metadataObj.stringValue != nil {
                //messageLabel.text = metadataObj.stringValue
                messageLabel.text = ""
                
                let item = Item(name: "$20 Food Gift Card", restaurant: "Tao", image: UIImage(named: "taowin")!)
                let cardView = CardView.instanceFromNib(CGRectMake(0, 0, 300, 300))
                cardView.item = item
                cardView.initializeScanView(hasScanned)
                
                if !hasScanned{
                    hasScanned = true
                }
                    
                let popupConfig = STZPopupViewConfig()
                popupConfig.dismissTouchBackground = true
                popupConfig.cornerRadius = 5.0
                
                self.presentPopupView(cardView, config:  popupConfig)
            }
        }
    }
    
    @IBAction func onBackButtonPressed(sender: AnyObject) {
        if let navController = self.navigationController {
            navController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
