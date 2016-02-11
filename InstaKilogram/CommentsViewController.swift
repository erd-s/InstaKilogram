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
    
    @IBOutlet weak var addCommentTextField: UITextField!
    
    @IBOutlet weak var commentTableView: UITableView!
    
    
    var postID: String?
    var comment = Dictionary<String,String>()
    var comments = [Dictionary<String,String>]()
    
    override func viewDidAppear(animated: Bool) {
        print(postID)
        let commentsRef = FirebaseData.firebaseData.PHOTOS_REF.childByAppendingPath(postID).childByAppendingPath("comments")

        commentsRef.observeEventType(.Value, withBlock: { snapshot in
            self.comments = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    
                    if let postDictionary = snap.value as? Dictionary <String, String> {
                        let username = postDictionary["username"]
                        let commentText = postDictionary["commentText"]
                        self.comment = ["username": username!, "commentText": commentText!]
                        self.comments.insert(self.comment, atIndex: 0)
                    }
                }
            }
            self.commentTableView.reloadData()
        })
        
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        let commentsRef = FirebaseData.firebaseData.PHOTOS_REF.childByAppendingPath(postID).childByAppendingPath("comments")
        if addCommentTextField.text?.characters.count > 0 {
            let commentDic = ["commentText": addCommentTextField.text!, "username": currentUsername!]
            commentsRef.childByAutoId().setValue(commentDic)
           // commentsRef.setValue(commentDic)
            
            
        }
    }
    
    @IBAction func backButtonTapped(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID")
        
        let comment = comments[indexPath.row]
        
        cell?.textLabel?.text = comment["commentText"]
        cell?.textLabel?.numberOfLines = 0
        cell?.detailTextLabel?.text = comment["username"]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
        
        
    }
    
}