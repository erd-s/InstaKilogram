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
    var caption:String?
    var location:String?
    var key: String?
    var hhmmss: String?
    var currentDate: String?
    var dateID: String?



    
    
    init(image: UIImage, captionText: String, locationString:String) {
        
        let imageData: NSData! = UIImageJPEGRepresentation(image, 0.5)
        let base64String = imageData.base64EncodedStringWithOptions([])
        
        photoLikes = 0
        username = currentUser
        photoString = base64String
        caption = captionText
        location = locationString
        
//        let date = NSDate()
        let dateComponents = NSDateComponents()
        let month = String(dateComponents.month)
        let year = String(dateComponents.year)
        let day = String(dateComponents.day)
        let hours = String(dateComponents.hour)
        let minutes = String(dateComponents.minute)
        let seconds = String(dateComponents.second)
        self.hhmmss = "\(hours):\(minutes):\(seconds)"
        self.currentDate = "\(month) \(day), \(year)"
        self.dateID = String(NSDate())

        
        
        
        userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String
        
        let photoDictionary = ["photoString"    : photoString! as String,
                                 "likes"        : photoLikes!,
                                 "user"         : username!,
                                 "userID"       : userID!,
                                "caption"       : caption!,
                                "location"      : location!,
                                "hh:mm:ss"     : hhmmss!,
                                "date"          : currentDate!,
                                "dateID"        : dateID!]
        
        let photosRef = FirebaseData.firebaseData.PHOTOS_REF.childByAutoId()

        
        photosRef.setValue(photoDictionary)
        
    }
    
    init(dictionary: Dictionary<String, AnyObject>) {
        
        photoString = dictionary["photoString"] as? String
        photoLikes = dictionary["photoLikes"] as? Int
        username = dictionary["user"] as? String
        userID  = dictionary["userID"] as? String
        caption = dictionary["caption"] as? String
        location = dictionary["location"] as? String
        currentDate = dictionary["date"] as? String
        hhmmss = dictionary["hh:mm:ss"] as? String
        dateID = dictionary["dateID"] as? String
        
        photo = UIImage()
        key  = String()
    }
    
    
    

    
        
        
        
}
    
    

    
    
    

