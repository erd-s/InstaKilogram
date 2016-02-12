//
//  LoginViewController.swift
//  InstaKilogram
//
//  Created by Jonathan Jones on 2/6/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase
import Twitter


class LoginViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //MARK: View Loading
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
//            if (session != nil) {
//                println("signed in as \(session.userName)");
//            } else {
//                println("error: \(error.localizedDescription)");
//            }
//        })
//        logInButton.center = self.view.center
//        self.view.addSubview(logInButton)
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    //MARK: Custom Functions
    func loginErrorAlert(tittle: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: Actions
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
                    FirebaseData.firebaseData.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
                        let currentUser = snapshot.value.objectForKey("username") as? String
                        print(currentUser)
                        self.userDefaults.setValue(currentUser, forKey: "currentUser")
                        self.performSegueWithIdentifier("loginSegue", sender: self)
                        
                        }, withCancelBlock: { error in
                            print(error.description)
                    })
                    print(FirebaseData.firebaseData.CURRENT_USER_REF)
                }
            })
            
        } else {
            loginErrorAlert("Error", message: "Please enter a username and password.")
        }
    }
    
    func twitterLogin()
    {
        let ref = Firebase(url: "https://instakilogram.firebaseio.com")
        let twitterAuthHelper = TwitterAuthHelper(firebaseRef: ref, apiKey:"LMCHua3RZ9MOBDtSyP0ibvU2L")
        twitterAuthHelper.selectTwitterAccountWithCallback { error, accounts in
            if error != nil {
                // Error retrieving Twitter accounts
            } else if accounts.count > 1 {
                // Select an account. Here we pick the first one for simplicity
                let account = accounts[0] as? ACAccount
                twitterAuthHelper.authenticateAccount(account, withCallback: { error, authData in
                    if error != nil {
                        // Error authenticating account
                    } else {
                        // User logged in!
                    }
                })
            }
        }
    }
    

    //MARK: Segue
    @IBAction func unwindCreate(segue: UIStoryboardSegue) {
    }
    
    
    
    
    
    
    
    
    
}
