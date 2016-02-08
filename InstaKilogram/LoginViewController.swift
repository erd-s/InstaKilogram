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
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if userDefaults.valueForKey("uid")  != nil {
            performSegueWithIdentifier("loginSegue", sender: self)
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if email?.characters.count > 0 && password?.characters.count > 0 {
            
            FirebaseData.firebaseData.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error != nil {
                    print(error.description)
                    self.loginErrorAlert("Error", message: "Check your username and password combination")
                    
                } else {
                    self.userDefaults.setValue(authData.uid, forKey: "uid")
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                }
            })
            
        } else {
            loginErrorAlert("Error", message: "Please enter a username and password.")
        }
    }
    
    
    func loginErrorAlert(tittle: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func unwindCreate(segue: UIStoryboardSegue) {}
    
    
    
    
    
    
    
    
    
}
