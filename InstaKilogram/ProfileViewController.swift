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
    var collectionItemsArray = [String]()
    var tableViewItemsArray = [String]()
    var currentUserData = [FDataSnapshot]()
    var currentUser = Dictionary<String, AnyObject>()
    var userPhotosArray = [UIImage]()
    var userDefaults = NSUserDefaults()
    var currentUserByNSUserDefaultsString: String?
    
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
    
    //MARK: ViewLoading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.hidden = true
        collectionView.hidden = false
        userDefaults = NSUserDefaults.standardUserDefaults()
        currentUserByNSUserDefaultsString = userDefaults.stringForKey("currentUser")
    }
    
    override func viewWillAppear(animated: Bool) {
        FirebaseData.firebaseData.USER_REF.observeEventType(.Value, withBlock: { snapshots in
            print(snapshots.value)
            
            for snapshot in snapshots.value as! [FDataSnapshot] {
                if self.currentUserByNSUserDefaultsString == snapshot.value["username"] as? String {
                    self.currentUser = snapshot.value as! Dictionary<String, AnyObject>
                }
            }
            
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
        })
//        
//        if (self.currentUser["photos"]!.count != 0) {
//            for photos in self.currentUser["photos"]!["photo"] {
//           
//            let decodedData = NSData(base64EncodedString: photo["photoString"], options: NSDataBase64DecodingOptions())
//            let decodedImage = UIImage(data: decodedData!)!
//                self.userPhotosArray.append(decodedImage)
//            }
//        }
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
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionItemsArray.count
    }
    
    //MARK: Collection View
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pizza", forIndexPath: indexPath)
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableViewItemsArray.count
    }
    
    //MARK: Segue stuff
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
        
    }






}
