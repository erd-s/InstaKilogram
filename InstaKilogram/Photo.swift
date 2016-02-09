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
    var photoString: String?
    var photoLikes: Int?
    var username: String?
    var userID: String?
    var photo: UIImage?
    
    
    init(image: UIImage) {
        photo = image
        let imageData: NSData! = UIImageJPEGRepresentation(photo!, 0.7)
        let base64String = imageData.base64EncodedStringWithOptions([])
        
        photoLikes = 0
        username = currentUser
        photoString = base64String
        
        
        
        userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String
        
        let photoDictionary = ["photoString"    : photoString! as String,
                                 "likes"        : photoLikes!,
                                 "user"         : username!,
                                 "userID"       : userID!]
        
        let photosRef = FirebaseData.firebaseData.PHOTOS_REF.childByAutoId()

        
        photosRef.setValue(photoDictionary)
        
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        photoString =   dictionary["photoString"]   as? String
        photoLikes =    dictionary["photoLikes"]    as? Int
        username =      dictionary["user"]          as? String
        userID  =       dictionary["userID"]        as? String
        
        let decodedData = NSData(base64EncodedString: photoString!, options: NSDataBase64DecodingOptions())
        
        photo = UIImage(data: decodedData!)!
            
            
    
        

    
    }
    
    
    

    
        
        
        
}
    
    

    
    
    

