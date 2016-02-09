//
//  Photo.swift
//  InstaKilogram
//
//  Created by Jonathan Jones on 2/8/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Photo {
    private var _photoRef: Firebase!

    private let _photoKey: String!
    private let _username: String!
    private let _photoLikes: Int!
    private let _photoString: String!
    private let _photoDictionary: [String: AnyObject]!
    

    var photoKey: String {
        return _photoKey
    }
    
    var photoString: String {
        return _photoString
    }
        
    var photoLikes: Int {
        return _photoLikes
    }
    
    var username: String {
        return _username
    }
    
    var photoDictionary: [String: AnyObject] {
        return _photoDictionary
    }
    
    init(user: String, image: UIImage) {
        
        let imageData: NSData! = UIImagePNGRepresentation(image)
        let base64String = imageData.base64EncodedStringWithOptions([])
        
    
        self._photoString = base64String
        
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        self._photoDictionary = ["photoString"  : self._photoString,
                                 "likes"        : 0,
                                 "user"         : currentUser,
                                 "userID"       : userID]
        
        
        FirebaseData.firebaseData.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
            let currentUser = snapshot.value.objectForKey("username")
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        
     //   let photoRef = FirebaseData.firebaseData.CURRENT_USER_REF.childByAppendingPath("photos").childByAutoId()
        
        //let photoRef = FirebaseData.firebaseData.CURRENT_USER_REF.childByAppendingPath("photos").childByAppendingPath(self._photoKey)
        
     //   photoRef.setValue(photoDic)
        
        let photosRef = FirebaseData.firebaseData.PHOTOS_REF.childByAutoId()
     //   let photoDic = ["Photo Storage URL": refPhotoURL]

       // let photosRef = FirebaseData.firebaseData.PHOTOS_REF.childByAppendingPath(self._photoKey)
        
        photosRef.setValue(self._photoDictionary)
        
    }
        
        
        
        
        
        
        
        
        
}
    
    

    
    
    

