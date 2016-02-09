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
    private let _photoString: String!
    private let _photoDictionary: [String: AnyObject]!
    
    var photoString: String {
        return _photoString
    }
    
    var photoDictionary: [String: AnyObject] {
        return _photoDictionary
    }
    
    var photoLikes: Int?
    var username: String?
    
    
    init(image: UIImage) {
        
        let imageData: NSData! = UIImagePNGRepresentation(image)
        let base64String = imageData.base64EncodedStringWithOptions([])
        
        photoLikes = 0
        username = currentUser
    
        self._photoString = base64String
        
        
        
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        self._photoDictionary = ["photoString"  : self._photoString,
                                 "likes"        : photoLikes!,
                                 "user"         : username!,
                                 "userID"       : userID]
        
        let photosRef = FirebaseData.firebaseData.PHOTOS_REF.childByAutoId()

        
        photosRef.setValue(self._photoDictionary)
        
    }
    
    
    

    
        
        
        
}
    
    

    
    
    

