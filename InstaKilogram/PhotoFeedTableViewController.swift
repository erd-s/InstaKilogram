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

class PhotoFeedTableViewController: UITableViewController, CommentButtonTappedDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var feedTableView: UITableView!
    
    var indexPath: NSIndexPath?
    
    
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
                        post.photo = UIImage(named: "loadingImage")
                        post.key = snap.key
                        self.posts.insert(post, atIndex: 0)
                        self.feedTableView.reloadData()
                    }
                }
                
                
            }
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                for post in self.posts {
                    let decodedData = NSData(base64EncodedString: post.photoString!, options: NSDataBase64DecodingOptions())
                    post.photo = UIImage(data: decodedData!)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.feedTableView.reloadData()
                }
            }
        })
        
    }
    
    
    
    
    //MARK: Button Taps
    @IBAction func onLikeButtonTap(sender: UIButton) {
    }
    
    func commentButtonTapped(cell: PhotoFeedCell) {
        indexPath = feedTableView.indexPathForCell(cell)
        performSegueWithIdentifier("commentSegue", sender: self)
    }
    
    
//    @IBAction func onCommentButtonTapped(sender: UIButton) {
//        performSegueWithIdentifier("commentSegue", sender: self)
//        
//    }
    
    
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
        
        cell.nameLabel.text =           photo.username
        cell.photoView.image =          photo.photo
        cell.likeCountLabel.text =      "Photo Likes: \(photo.photoLikes)"
        cell.captionTextView.text =     photo.caption
//      cell.commentsLabel.text =     photo.username
        if(photo.location != "")
        {
            cell.geoLocationLabel.text = photo.location
        }
        else
        {
            cell.geoLocationLabel.hidden = true
        }

        return cell
    }
    
    
}
