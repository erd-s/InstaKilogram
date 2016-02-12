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
    //MARK: Properties
    var posts = [Photo]()
    var yOffset: CGFloat = 0
    var indexPath: NSIndexPath?
    var postKey: String?
    var comment1: String?
    var comment2: String?
    
    //MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var feedTableView: UITableView!
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //         yOffset = feedTableView.contentOffset.y
        let userDefaults = NSUserDefaults.standardUserDefaults()
        currentUsername = userDefaults.valueForKey("currentUser") as? String
        navigationItem.title = "\(currentUsername!)'s InstaKilogram"
        
        FirebaseData.firebaseData.PHOTOS_REF.observeEventType(.Value, withBlock: { snapshot in
            self.posts = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let postDictionary = snap.value as? Dictionary <String, AnyObject> {
                        let post = Photo(dictionary: postDictionary)
                        post.photo = UIImage(named: "loadingImage")
                        post.key = snap.key
                        
                        if postDictionary["comments"] != nil {
                            post.comments = [String]()
                            let commentDic = postDictionary["comments"] as! NSDictionary
                            var commentDicArray = commentDic.allKeys
                            if commentDicArray.count > 1 {
                                let username2 = (commentDic["\(commentDicArray[1])"]!["username"]!)
                                let commentText2 = (commentDic["\(commentDicArray[1])"]!["commentText"]!)
                                let username1 = (commentDic["\(commentDicArray[0])"]!["username"]!)
                                let commentText1 = (commentDic["\(commentDicArray[0])"]!["commentText"]!)
                                self.comment2 = "\(username2!): \(commentText2!)"
                                self.comment1 = "\(username1!): \(commentText1!)"
                                
//                                print(self.comment1!)
//                                print(self.comment2!)
                                post.comments?.append(self.comment1!)
                                post.comments?.append(self.comment2!)
                                print(self.comment1)
                                print(self.comment2)
                                print(post.comments)
                            } else if commentDicArray.count == 1 {
                                let username1 = (commentDic["\(commentDicArray[0])"]!["username"]!)
                                let commentText1 = (commentDic["\(commentDicArray[0])"]!["commentText"]!)
                                self.comment1 = "\(username1!): \(commentText1!)"
                                post.comments?.append(self.comment1!)
                                print(post.comments)


                            
                            }
                            print("------")
                        }
                                               let commentDictionary = postDictionary["comments"] as? [Dictionary <String, Dictionary<String,String>>]
                        
                        
                       // print(commentDictionary)
                        if commentDictionary?[1] != nil {
                            self.comment1 = "\(commentDictionary![0]["username"]): \(commentDictionary![0]["commentText"])"
                            self.comment2 = "\(commentDictionary![1]["username"]): \(commentDictionary![0]["commentText"])"
                            post.comments?.append(self.comment1!)
                            post.comments?.append(self.comment2!)
                            
                            
                        } else if commentDictionary?[0] != nil {
                            self.comment1 = "\(commentDictionary![0]["username"]): \(commentDictionary![0]["commentText"])"
                            post.comments?.append(self.comment1!)
                            
                        }
                        
                        
                        self.posts.insert(post, atIndex: 0)
                        
                        
                        self.feedTableView.reloadData()
                    }
                }
            }
            self.feedTableView.contentOffset.y = self.yOffset
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
        let photo = posts[indexPath.row]
        let decodedData = NSData(base64EncodedString: photo.photoString!, options: NSDataBase64DecodingOptions())
        
        
        cell.commentsLabel.numberOfLines = 0
    
        if photo.comments != nil {
            if photo.comments!.count > 1 {
                cell.commentsLabel.text = "Comments \n \(photo.comments![0]) \n \(photo.comments![1]) \n ..."
            } else if photo.comments?.count == 1 {
                cell.commentsLabel.text = "Comments \n \(photo.comments![0]) \n ..."
            }
        } else {
            cell.commentsLabel.text = "No Comments"
        }
        
        cell.delegate = self
        cell.likeDelegate = self
        cell.photoView.image = UIImage(data: decodedData!)
        cell.nameLabel.text =           photo.username
        cell.likeCountLabel.text =      "Photo Likes: \(photo.photoLikes!)"
        cell.captionTextView.text =     photo.caption
        
        if photo.comments?.count != nil {
            if photo.comments!.count > 1 {
                cell.commentsLabel.text = "Comments \n \(photo.comments![0]) \n \(photo.comments![1]) \n ..."
            } else if photo.comments!.count == 1 {
                cell.commentsLabel.text = "Comments \n \(photo.comments![0]) \n ..."
            }
        }
        
        
        setCellDate(cell, photo: photo)
        
        if(photo.location != "")
        {
            cell.geoLocationLabel.text = photo.location
        }
        else {
            cell.geoLocationLabel.hidden = true
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
