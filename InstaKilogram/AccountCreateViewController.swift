//
//  AccountCreateViewController.swift
//  InstaKilogram
//
//  Created by Jonathan Jones on 2/7/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase

class AccountCreateViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
         return textField.resignFirstResponder()
    }
    
    
    @IBAction func createAccount(sender: UIButton) {
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if username?.characters.count > 0 && email?.characters.count > 0 && password!.characters.count > 0 {
            FirebaseData.firebaseData.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
                
                if error != nil {
                    
                    print(error.description)
                    
                } else {
                    
                    FirebaseData.firebaseData.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                        
                        let user = ["provider":authData.provider!, "email": email!, "username": username!]
                        
                        FirebaseData.firebaseData.createNewAccount(authData.uid, user: user)
                        
                        self.performSegueWithIdentifier("unwindSegue", sender: self)
                        
                    })
                }
                
                
            })
            
            
        }
        
        
        
        
    }
    
    
}
