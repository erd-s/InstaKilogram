//
//  PhotoFeedTableViewController.swift
//  InstaKilogram
//
//  Created by Christopher Erdos on 2/5/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase

class PhotoFeedTableViewController: UITableViewController {
    //MARK: Properties
    
    
    //MARK: Outlets
    
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PhotoFeedCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pizza", forIndexPath: indexPath) as! PhotoFeedCell
        
//        cell.photoView.image = 
//        cell.commentsLabel.text = 
//        cell.likeCountLabel.text = 
        
        return cell
    }
    

  }
