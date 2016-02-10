//
//  EditUserViewController.swift
//  InstaKilogram
//
//  Created by Christopher Erdos on 2/7/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase

class EditUserViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    //MARK: Properties
    var currentUser = Dictionary<String, AnyObject>()
    
    //MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionTextView.layer.cornerRadius = 5
        self.descriptionTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.descriptionTextView.layer.borderWidth = 0.5
        
        
        FirebaseData.firebaseData.CURRENT_USER_REF.observeSingleEventOfType(.Value, withBlock: { snapshot in
            self.currentUser = snapshot.value as! Dictionary<String, AnyObject>
            
            self.descriptionTextView.text = self.currentUser["description"] as? String
            self.descriptionTextView?.textColor = UIColor.blackColor()
            self.nameTextField.text = self.currentUser["name"] as? String
            self.usernameTextField.text = self.currentUser["username"] as? String
            self.websiteTextField.text = self.currentUser["website"] as? String
            self.emailTextField.text = self.currentUser["email"] as? String
            self.phoneNumberTextField.text = self.currentUser["phoneNumber"] as? String
            
            if (self.currentUser["userPhoto"] != nil) {
            let photoData = NSData(base64EncodedString: (self.currentUser["userPhoto"] as? String)!, options: NSDataBase64DecodingOptions())
            self.userImageView.image = UIImage(data: photoData!)
            } else {
                self.userImageView.image = UIImage(named: "defaultPhoto")
            }
        })
    }
    //MARK: Custom Functions

    
    //MARK: Actions
    @IBAction func cancelButtonTapped(sender: UIButton) {
     
    }
    
    @IBAction func doneButtonTapped(sender: UIButton) {
        let currentUserDict =
            ["description": self.descriptionTextView.text,
             "name": self.nameTextField.text,
             "username": self.usernameTextField.text,
             "email": self.emailTextField.text,
             "phoneNumber": self.phoneNumberTextField.text]
        
        FirebaseData.firebaseData.CURRENT_USER_REF.setValue(currentUserDict)
        performSegueWithIdentifier("unwindToProfile", sender: self)
    }
    
    
    //MARK: TextField Delegate Functions
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    //MARK: TextView Delegate Functions
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    
    
}
