//
//  PhotoFeedTableViewController.swift
//  InstaKilogram
//
//  Created by Christopher Erdos on 2/5/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase

var currentUser: String?

class PhotoFeedTableViewController: UITableViewController {
    //MARK: Properties
    var posts = [Photo]()
    
    
    //MARK: Outlets
    
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        currentUser = userDefaults.valueForKey("currentUser") as? String

        
        FirebaseData.firebaseData.PHOTOS_REF.observeEventType(.Value, withBlock: { snapshot in
            self.posts = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let postDictionary = snap.value as? Dictionary <String, AnyObject> {
                        let post = Photo(dictionary: postDictionary)
                        self.posts.insert(post, atIndex: 0)
                        
                    }
                }
            }
            
        })
        
    }



 
    //MARK: Button Taps
    @IBAction func onLikeButtonTap(sender: UIButton) {
    }
    
   
    @IBAction func onCommentButtonTapped(sender: UIButton) {
    }
    
    
    @IBAction func onForwardButtonTap(sender: AnyObject) {
    }
    
    @IBAction func onDotDotDotButtonTapped(sender: UIButton) {
    }
    
    
    //MARK: TableView Stuff
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PhotoFeedCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pizza", forIndexPath: indexPath) as! PhotoFeedCell
        
        let photo = posts[indexPath.row] 
        
        cell.photoView.image =          photo.photo
    //    cell.commentsLabel.text =       photo.username
        cell.likeCountLabel.text =      "\(photo.photoLikes)"
        
        return cell
    }
    

  }
