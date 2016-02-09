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
    
    //MARK: ViewLoading
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.hidden = true
        collectionView.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {
        startListeningAndSetCurrentUser()
        getPhotos()
    }
    
    //MARK: Custom Functions
    func startListeningAndSetCurrentUser () {
        FirebaseData.firebaseData.CURRENT_USER_REF.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value.description)
            self.currentUser = snapshot.value as! Dictionary<String, AnyObject>
            self.usernameTitleLabel.text? = self.currentUser["username"]!.uppercaseString
            if (self.currentUser["name"] != nil) {
                self.nameLabel.text = self.currentUser["name"] as? String
            }
            if (self.currentUser["description"] != nil) {
                self.descriptionLabel.text = self.currentUser["description"] as? String
            }
            else {
                self.descriptionLabel.text = "Please click 'Edit Profile' to add a description."
                self.descriptionLabel.textColor = UIColor.lightGrayColor()
            }
            if self.currentUser["followers"] != nil {
                self.followersNumberLabel.text = String(self.currentUser["followers"]!.count)
            } else {
                self.followersNumberLabel.text = "0"
            }
            if self.currentUser["following"] != nil {
                self.followingNumberLabel.text = String(self.currentUser["following"]!.count)
            } else {
                self.followingNumberLabel.text = "0"
            }
            self.nameLabel.text = self.currentUser["name"] as? String
            
            if self.currentUser["userPhoto"] == nil {
                self.userImage.image = UIImage(named: "defaultPhoto")
            } else {
                let decodedData = NSData(base64EncodedString: (self.currentUser["userPhoto"] as? String)!, options: NSDataBase64DecodingOptions())
                let decodedImage = UIImage(data: decodedData!)
                self.userImage.image = decodedImage
            }
        })
    }
    
    func getPhotos () {
        FirebaseData.firebaseData.PHOTOS_REF.observeEventType(.Value, withBlock: { snapshots in
            for snapshot in snapshots.children.allObjects as! [FDataSnapshot] {
                if snapshot.value!["user"]! as! String == self.userDefaults.stringForKey("currentUser")! {
                    let decodedData = NSData(base64EncodedString: (snapshot.value["photoString"] as? String)!, options: NSDataBase64DecodingOptions())
                    let decodedImage = UIImage(data: decodedData!)
                    self.userPhotosArray.insert(decodedImage!, atIndex: 0)
                    print(self.userPhotosArray[0])
                    self.tableView.reloadData()
                    self.collectionView.reloadData()
                }
            }
    })
    }

    //MARK: Custom Functions
    func switchForSegment(segmentedControl: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView.hidden = true
            collectionView.hidden = false
        } else {
            tableView.hidden = false
            collectionView.hidden = true
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
        let cell = tableView.dequeueReusableCellWithIdentifier("pizza")!
        let postImage = userPhotosArray[indexPath.row]
        
        cell.imageView?.image = postImage
        
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPhotosArray.count
    }
    
    //MARK: Collection View
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pizza", forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotosArray.count
    }
    
    //MARK: Segue stuff
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}
