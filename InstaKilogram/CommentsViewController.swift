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
    var comments: [Dictionary <String, String>]?
    
    
    
    override func viewDidAppear(animated: Bool) {
        print(postID)
        let commentsRef = FirebaseData.firebaseData.PHOTOS_REF.childByAppendingPath("postID").childByAppendingPath("comments")
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID")
        
        let comment = comments![indexPath.row]
        
        cell?.textLabel?.text = comment["commentText"]
        cell?.detailTextLabel?.text = comment["username"]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if comments?.count != nil {
            return comments!.count
        } else {
            return 0
        }
        
    }

}