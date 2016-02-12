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
    
    //MARK: Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: View Loading
    override func viewDidAppear(animated: Bool) {
        let noCapitalization = UITextAutocapitalizationType.None
        
        usernameTextField.autocapitalizationType = noCapitalization
        passwordTextField.autocapitalizationType = noCapitalization
        emailTextField.autocapitalizationType = noCapitalization
        
        
    }
    
    //MARK: TextField Delegate Functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    //MARK: Actions
    @IBAction func createAccount(sender: UIButton) {
        let username = usernameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        
        if username?.characters.count > 0 && email?.characters.count > 0 && password!.characters.count > 0 {
            FirebaseData.firebaseData.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
                if error != nil {
                    print(error.description)
                } else {
                    FirebaseData.firebaseData.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                        let user = ["provider":authData.provider!, "email": email!, "username": username!, "name": name!]
                        FirebaseData.firebaseData.createNewAccount(authData.uid, user: user)
                        
                        self.performSegueWithIdentifier("unwindCreate", sender: self)
                    })
                }
            })
        }
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        performSegueWithIdentifier("unwindCreate", sender: self)
    }
    
    
}
