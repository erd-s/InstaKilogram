//
//  ExploreViewController.swift
//  InstaKilogram
//
//  Created by Yemi Ajibola on 2/4/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit


class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    //MARK: Properties
    var photoCollectionArray = [UIImage]()  //this array type may need to change
    var searchResultsArray = [UIImage]()    //and this one too
    
    //MARK: Outlets
    @IBOutlet var searchBar: UISearchBar!
    
    
    //MARK: ViewLoading
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getResults(searchQuery: String) {
//        get data from searchQuery

//        for data in searchData {
//            
//            searchResultsArray.append(data)
//        }
        
        
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        getResults(searchBar.text!)
    }
    
    
    //MARK: CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchBar.text == "" {
        return photoCollectionArray.count
        } else {
            return searchResultsArray.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pizza", forIndexPath: indexPath)
        
        return cell
    }
    
    
    

}
