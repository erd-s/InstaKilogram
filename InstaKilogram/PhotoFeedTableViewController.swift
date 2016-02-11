//
//  PhotoFeedTableViewController.swift
//  InstaKilogram
//
//  Created by Christopher Erdos on 2/5/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase

var currentUsername: String?

class PhotoFeedTableViewController: UITableViewController, LikeButtonTappedDelegate, CommentButtonTappedDelegate{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var feedTableView: UITableView!
    
    var indexPath: NSIndexPath?
    var postKey: String?
    
    //MARK: Properties
    var posts = [Photo]()
    
    var yOffset: CGFloat = 0
    
    
    //MARK: Outlets
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
//         yOffset = feedTableView.contentOffset.y
        let userDefaults = NSUserDefaults.standardUserDefaults()
        currentUsername = userDefaults.valueForKey("currentUser") as? String
        
        
        FirebaseData.firebaseData.PHOTOS_REF.observeEventType(.Value, withBlock: { snapshot in
            self.posts = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let postDictionary = snap.value as? Dictionary <String, AnyObject> {
                        let post = Photo(dictionary: postDictionary)
<<<<<<< HEAD
                        //                        post.photo = UIImage(named: "loadingImage")
=======
                        post.photo = UIImage(named: "loadingImage")
>>>>>>> Finished like functionality
                        post.key = snap.key
                        self.posts.insert(post, atIndex: 0)
                        self.feedTableView.reloadData()
                    }
                    
                }
                
                
            }
<<<<<<< HEAD
=======
            self.feedTableView.contentOffset.y = self.yOffset

>>>>>>> Finished like functionality
        })
        
    }
    
    //MARK: Custom Functions
    func setCellDate(cell: PhotoFeedCell, photo: Photo) {
        let thisDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        let dateString = dateFormatter.stringFromDate(thisDate)
        
        if photo.currentDate == dateString {
            cell.timestampLabel.text = photo.hhmmss
        } else {
            cell.timestampLabel.text = photo.currentDate
        }
    }
    
    
    //MARK: Button Taps
    
    func commentButtonTapped(cell: PhotoFeedCell) {
        indexPath = feedTableView.indexPathForCell(cell)
        postKey = posts[indexPath!.row].key
        performSegueWithIdentifier("commentSegue", sender: self)
    }
    

    func likeButtonTapped(cell: PhotoFeedCell) {
        yOffset = feedTableView.contentOffset.y
        indexPath = feedTableView.indexPathForCell(cell)
        let selPost = posts[indexPath!.row]
        postKey = posts[indexPath!.row].key
        selPost.photoLikes = selPost.photoLikes! + 1
        
        FirebaseData.firebaseData.PHOTOS_REF.childByAppendingPath(postKey).childByAppendingPath("likes").setValue(selPost.photoLikes)
        feedTableView.reloadData()
        print("like button is tapped")
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
        
        cell.delegate = self
        cell.likeDelegate = self
        
        let photo = posts[indexPath.row]
        
        cell.photoView.image = UIImage(named: "loadingImage")
        cell.nameLabel.text =           photo.username
        cell.likeCountLabel.text =      "Photo Likes: \(photo.photoLikes!)"
        cell.captionTextView.text =     photo.caption
        
        setCellDate(cell, photo: photo)
        
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
<<<<<<< HEAD
            //            cell.photoView.image = UIImage(data: decodedData!)
=======
>>>>>>> Finished like functionality
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
