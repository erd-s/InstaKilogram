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
    
    //MARK: Outlets
    @IBOutlet weak var postNumberLabel: UILabel!
    @IBOutlet weak var followersNumberLabel: UILabel!
    @IBOutlet weak var followingNumberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTitleLabel: UILabel!
    
    //MARK: ViewLoading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.hidden = true
        collectionView.hidden = false
        
        FirebaseData.firebaseData.CURRENT_USER_REF.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            self.currentUser = snapshot.value as! Dictionary<String, AnyObject>
            self.usernameTitleLabel.text? = self.currentUser["username"]!.uppercaseString
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
