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
    var postKey: String?
    
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
//                        post.photo = UIImage(named: "loadingImage")
                        post.key = snap.key
                        self.posts.insert(post, atIndex: 0)
                        self.feedTableView.reloadData()
                    }
                }
                
                
            }
//            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
//            dispatch_async(dispatch_get_global_queue(priority, 0)) {
//                for post in self.posts {
//                    let decodedData = NSData(base64EncodedString: post.photoString!, options: NSDataBase64DecodingOptions())
//                    post.photo = UIImage(data: decodedData!)
//                }
//                
//                dispatch_async(dispatch_get_main_queue()) {
//                    self.feedTableView.reloadData()
//                }
//            }
        })
        
    }
    
    
    
    
    //MARK: Button Taps
    
    func commentButtonTapped(cell: PhotoFeedCell) {
        indexPath = feedTableView.indexPathForCell(cell)
        postKey = posts[indexPath!.row].key
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
        
        cell.delegate = self
        
        let photo = posts[indexPath.row]
        
        cell.photoView.image = UIImage(named: "loadingImage")
        cell.nameLabel.text =           photo.username
        cell.likeCountLabel.text =      "Photo Likes: \(photo.photoLikes)"
        cell.captionTextView.text =     photo.caption
        
        if photo.dateID == String(NSDate()) {
        cell.timestampLabel.text = photo.hhmmss
        } else {
        cell.timestampLabel.text = photo.currentDate
        }
        
        
        print("For Cell: \(photo.location)")
        if(photo.location != "")
        {
            cell.geoLocationLabel.text = photo.location
        }
        else
        {
            cell.geoLocationLabel.hidden = true
        }
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let decodedData = NSData(base64EncodedString: photo.photoString!, options: NSDataBase64DecodingOptions())
//            cell.photoView.image = UIImage(data: decodedData!)
            dispatch_async(dispatch_get_main_queue()) {
                cell.photoView.image = UIImage(data: decodedData!)

            }

        }

        


        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "commentSegue" {
        let dvc = segue.destinationViewController as! CommentsViewController
        dvc.postID = postKey
        }
    }
    
    
}
