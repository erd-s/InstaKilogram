//
//  CommentsViewController.swift
//  InstaKilogram
//
//  Created by Jonathan Jones on 2/10/16.
//  Copyright © 2016 mm. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var postID: String?
    
    

    override func viewDidAppear(animated: Bool) {
        
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID")
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    

}
