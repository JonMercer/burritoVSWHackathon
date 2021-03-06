//
//  LoginVC.swift
//  Burrito
//
//  Created by Gordon Seto on 2016-09-24.
//  Copyright © 2016 TeamAlpaka. All rights reserved.
//

import UIKit
import ButtonAndLabelActivitySpinner
import FirebaseAuth

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RoundedButton!
    @IBOutlet weak var spinLabel: LabelActivitySpinner!
    
    var LOGIN_DELAY = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        self.navigationController?.navigationBarHidden = true
        hideKeyboardWhenTappedAround()
        
        emailTextField.text = "test@getburrito.com"
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
        loginButton.hidden = true
        spinLabel.activityIndicator.color = UIColor(red: 255.0/255.0, green: 64.0/255.0, blue: 64.0/255.0, alpha: 1.0)
        spinLabel.startAnimating()

        loginUser(){}
        
        delay(LOGIN_DELAY){
            self.performSegueWithIdentifier("qrScanVCFromLoginVC", sender: nil)
            self.spinLabel.stopAnimating()
            self.loginButton.hidden = false
        }
    }
    
    func loginUser(completion:()->()){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        FIRAuth.auth()?.signInWithEmail(email, password: password){ (user, error) in
            if error != nil {
                FIRAuth.auth()?.createUserWithEmail(email, password: password){(user, error) in
                    completion()
                }
            }
        }
    }
}
