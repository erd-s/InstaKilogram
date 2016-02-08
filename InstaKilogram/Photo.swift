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

class Photo: UIImageView{
    private var _photoRef: Firebase!
    
    private var _photoKey: String!
    private var _username: String!
    private var _photoLikes: Int!
    private var _photoImage: UIImage?
    

    var photoKey: String {
        return _photoKey
    }
    
    var photoImage: UIImage? {
        return _photoImage
    }
        
    var photoLikes: Int {
        return _photoLikes
    }
    
    var username: String {
        return _username
    }
    // The photo string is the NSData Photo object pulled from Firebase, so it should be the UIImage in string form.

    
    
    
}
