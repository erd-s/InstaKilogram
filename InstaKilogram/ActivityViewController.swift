//
//  ActivityViewController.swift
//  InstaKilogram
//
//  Created by Christopher Erdos on 2/6/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var arrayWithYourActivity = [String]()
    var arrayWithFollowingActivity = [String]()
    
    //MARK: Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: ViewLoading
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func onChangeSegmentedControlSelection(sender: AnyObject) {
        tableView.reloadData()
        
    }
    
    
    //MARK: TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 0{
            return arrayWithFollowingActivity.count
        } else {
            return arrayWithYourActivity.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pizza")!
      
        if segmentedControl.selectedSegmentIndex == 0 {
//            let stuff = arrayWithFollowingActivity[indexPath.row]
        }
        else {
//            let stuff = arrayWithYourActivity[indexPath.row]
        }
//        cell.contents = stuff.property
        
        
        return cell
    }
}
