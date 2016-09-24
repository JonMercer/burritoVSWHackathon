//
//  LoginVC.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.navigationController?.navigationBarHidden = true
        hideKeyboardWhenTappedAround()
        
    }

    @IBAction func onBackButtonPressed(sender: AnyObject) {
        print("hi")
        if let navController = self.navigationController {
            navController.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func onLoginPressed(sender: AnyObject) {
        performSegueWithIdentifier("qrScanVCFromLoginVC", sender: nil)
    }
}
