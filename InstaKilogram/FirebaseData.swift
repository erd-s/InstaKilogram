//
//  Constants.swift
//  InstaKilogram
//
//  Created by Jonathan Jones on 2/7/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import Foundation
import Firebase

class FirebaseData {
    static let firebaseData = FirebaseData()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _PHOTOS_REF = Firebase(url: "\(BASE_URL)/photos")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var PHOTOS_REF: Firebase {
        return _PHOTOS_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        return currentUser!
    }
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        USER_REF.childByAppendingPath(uid).setValue(user)
        
    
    }
}
