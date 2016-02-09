//
//  LoginViewController.swift
//  InstaKilogram
//
//  Created by Jonathan Jones on 2/6/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase

var currentUser: String?

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
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
                    
                    FirebaseData.firebaseData.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
                        currentUser = snapshot.value.objectForKey("username") as? String
                        self.userDefaults.setValue(currentUser, forKey: "currentUser")
                        self.performSegueWithIdentifier("loginSegue", sender: self)
                        
                        }, withCancelBlock: { error in
                            print(error.description)
                    })

                    self.userDefaults.setValue(authData.uid, forKey: "uid")
                    print(FirebaseData.firebaseData.CURRENT_USER_REF)
                    
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
