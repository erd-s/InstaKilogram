//
//  User.swift
//  InstaKilogram
//
//  Created by Christopher Erdos on 2/7/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit

class User: NSDictionary {

    var username: String!
    var custom_ID: Int!
    var password: String!
    var email: String!
    var phone: String!
    var customIDInt: Int = 0
    
    func initWithUserInfo(username: String, password: String, email: String, phone: String){
        self.username = username
        self.password = password
        self.email = email
        self.phone = phone
        self.customIDInt += 1
        
        self.custom_ID = customIDInt
        
    }
    
    
}
