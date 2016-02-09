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

    private let _photoString: String!
    private let _photoDictionary: [String: AnyObject]!
    
    var photoString: String {
        return _photoString
    }
    
    
    var photoDictionary: [String: AnyObject] {
        return _photoDictionary
    }
    
    init(image: UIImage) {
        
        let imageData: NSData! = UIImagePNGRepresentation(image)
        let base64String = imageData.base64EncodedStringWithOptions([])
        
    
        self._photoString = base64String
        
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        self._photoDictionary = ["photoString"  : self._photoString,
                                 "likes"        : 0,
                                 "user"         : currentUser!,
                                 "userID"       : userID]
        
        let photosRef = FirebaseData.firebaseData.PHOTOS_REF.childByAutoId()
        
        photosRef.setValue(self._photoDictionary)
        
    }
        
        
        
        
        
        
        
        
        
}
    
    

    
    
    

