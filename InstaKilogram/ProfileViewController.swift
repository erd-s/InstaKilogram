//
//  ProfileViewController.swift
//  InstaKilogram
//
//  Created by Christopher Erdos on 2/6/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    //MARK: Properties
    var currentUserData = [FDataSnapshot]()
    var currentPhotoData = [FDataSnapshot]()
    var currentUser = Dictionary<String, AnyObject>()
    var userPhotosArray = [UIImage]()
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    //MARK: Outlets
    @IBOutlet weak var postNumberLabel: UILabel!
    @IBOutlet weak var followersNumberLabel: UILabel!
    @IBOutlet weak var followingNumberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTitleLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    //MARK: ViewLoading
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.hidden = true
        collectionView.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        startListeningAndSetCurrentUser()
        getPhotos()
        
        collectionViewFlowLayout.itemSize = CGSize.init(width: collectionView.frame.width/3, height: collectionView.frame.width/3)
    }
    
    //MARK: Custom Functions
    func startListeningAndSetCurrentUser () {
        FirebaseData.firebaseData.CURRENT_USER_REF.observeSingleEventOfType(.Value, withBlock: { snapshot in
            self.currentUser = snapshot.value as! Dictionary<String, AnyObject>
            self.usernameTitleLabel.text? = self.currentUser["username"]!.uppercaseString

            self.nameLabel.text = self.currentUser["name"] as? String
            if (self.currentUser["description"] != nil) {
                self.descriptionLabel.text = self.currentUser["description"] as? String
            }
            else {
                self.descriptionLabel.text = "Please click 'Edit Profile' to add a description."
                self.descriptionLabel.textColor = UIColor.lightGrayColor()
            }
            if self.currentUser["followers"] != nil {
                self.followersNumberLabel.text = String(self.currentUser["followers"]!.count)
            }
            
            if self.currentUser["following"] != nil {
                self.followingNumberLabel.text = String(self.currentUser["following"]!.count)
            }
            self.nameLabel.text = self.currentUser["name"] as? String
            
            if self.currentUser["userPhoto"] == nil {
                self.userImage.image = UIImage(named: "defaultPhoto")
            } else {
                let decodedData = NSData(base64EncodedString: (self.currentUser["userPhoto"] as? String)!, options: NSDataBase64DecodingOptions())
                let decodedImage = UIImage(data: decodedData!)
                self.userImage.image = decodedImage
            }
            self.tableView.reloadData()
            self.collectionView.reloadData()
        })
    }
    
    func getPhotos () {
        FirebaseData.firebaseData.PHOTOS_REF.observeEventType(.Value, withBlock: { snapshots in
            self.userPhotosArray.removeAll()
            self.currentPhotoData.removeAll()
            for snapshot in snapshots.children.allObjects as! [FDataSnapshot] {
                if snapshot.value!["userID"]! as! String == self.userDefaults.stringForKey("uid")! {
                    let decodedData = NSData(base64EncodedString: (snapshot.value["photoString"] as? String)!, options: NSDataBase64DecodingOptions())
                    let decodedImage = UIImage(data: decodedData!)
                    self.userPhotosArray.insert(decodedImage!, atIndex: 0)
                    self.currentPhotoData.insert(snapshot, atIndex: 0)
                    self.postNumberLabel.text = String(self.userPhotosArray.count)
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
            }
    })
    }

    func switchForSegment(segmentedControl: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0
        {
            tableView.hidden = true
            collectionView.hidden = false
            
        }
        else if segmentedControl.selectedSegmentIndex == 1
        {
            tableView.hidden = false
            collectionView.hidden = true
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            performSegueWithIdentifier("mapSegue", sender: segmentedControl)
            
        }
    }
    
    //MARK: IBActions
    @IBAction func onEditProfileButtonTapped(sender: UIButton) {
    }
    
    @IBAction func onSelectedSegmentChanged(segmentedControl: UISegmentedControl) {
        switchForSegment(segmentedControl)
    }
    
    //MARK: Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pizza")! as! PhotoFeedCell
        let postImage = userPhotosArray[indexPath.row]
        let postData = currentPhotoData[indexPath.row]

        cell.photoView?.image = postImage
        cell.nameLabel?.text = currentUser["username"] as? String
        let likesString = String(postData.value["likes"] as! Int)
        cell.likeCountLabel?.text = "Likes: \(likesString)"
        cell.captionTextView?.text = postData.value["caption"] as? String
        cell.geoLocationLabel.text = postData.value?["geolocation"] as? String
        cell.commentsLabel?.text = postData.value?["comments"] as? String
        
        if postData.value["dateID"] as? String == String(NSDate()) {
            cell.timestampLabel.text = postData.value["hh:mm:ss"] as? String
        } else {
            cell.timestampLabel.text = postData.value["date"] as? String
        }
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPhotosArray.count
    }
    
    //MARK: Collection View
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pizza", forIndexPath: indexPath) as! PhotoCollectionViewCell
        let currentPhoto = userPhotosArray[indexPath.row]
        cell.photoView.image = currentPhoto
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotosArray.count
    }
    
    //MARK: Segue stuff
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapSegue" {
        let mapVC = segue.destinationViewController as? MapViewController
        mapVC!.currentPhotoData = self.currentPhotoData
        }
        
    }
}
