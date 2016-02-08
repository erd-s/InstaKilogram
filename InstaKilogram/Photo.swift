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

class Photo: NSDictionary{
    private var _photoRef: Firebase!
    
    
    var name: String?
    var likes: Int?
    var owner: String?
    var photo: UIImage?
    
    // The photo string is the NSData Photo object pulled from Firebase, so it should be the UIImage in string form.

    
    
    
}
