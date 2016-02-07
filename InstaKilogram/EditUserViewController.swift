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
    }

    
    //MARK: Actions
    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        
        
        
    }
    
    @IBAction func doneButtonTapped(sender: UIButton) {
        
        
        
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
