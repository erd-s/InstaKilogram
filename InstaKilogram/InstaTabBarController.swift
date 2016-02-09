//
//  InstaTabBarController.swift
//  InstaKilogram
//
//  Created by Jonathan Jones on 2/8/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class InstaTabBarController: UITabBarController {
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
                FirebaseData.firebaseData.CURRENT_USER_REF.observeEventType(FEventType.Value, withBlock: { snapshot in
            currentUser = snapshot.value.objectForKey("username") as? String
            
            
            }, withCancelBlock: { error in
                print(error.description)
        })

    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

}
