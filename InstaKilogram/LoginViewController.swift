//
//  LoginViewController.swift
//  InstaKilogram
//
//  Created by Jonathan Jones on 2/6/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
   
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if userDefaults.valueForKey("name")  != nil {
                performSegueWithIdentifier("loginSegue", sender: self)
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text?.characters.count > 0 {
            userDefaults.setValue(textField.text, forKey: "name")
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }

    @IBAction func loginButtonTapped(sender: UIButton) {
        if usernameTextField.text?.characters.count > 0 {
            userDefaults.setValue(usernameTextField.text, forKey: "name")
            performSegueWithIdentifier("loginSegue", sender: self)
            
        }
        
    }
}
