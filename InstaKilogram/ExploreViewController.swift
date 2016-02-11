//
//  ExploreViewController.swift
//  InstaKilogram
//
//  Created by Yemi Ajibola on 2/4/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase


class ExploreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    //MARK: Properties
    var userPhotosArray = [UIImage]()  //this array type may need to change
    var searchResultsArray = [UIImage]()    //and this one too
    var filteredPhotoArray = [UIImage]()
    var arrayWithData = [FDataSnapshot]()
    
    //MARK: Outlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: ViewLoading
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.itemSize = CGSize.init(width: collectionView.frame.width/3, height: collectionView.frame.width/3)
    }
    override func viewWillAppear(animated: Bool) {
        grabPhotos()
        searchBar.autocapitalizationType = UITextAutocapitalizationType.None
    }
    
    func grabPhotos(){
        FirebaseData.firebaseData.PHOTOS_REF.observeSingleEventOfType(.Value, withBlock: { snapshots in
            self.userPhotosArray.removeAll()
            self.arrayWithData = snapshots.children.allObjects as! [FDataSnapshot]
            for snapshot in snapshots.children.allObjects as! [FDataSnapshot] {
                let decodedData = NSData(base64EncodedString: (snapshot.value["photoString"] as? String)!, options: NSDataBase64DecodingOptions())
                let decodedImage = UIImage(data: decodedData!)
                self.userPhotosArray.insert(decodedImage!, atIndex: 0)
                self.collectionView.reloadData()
                self.filteredPhotoArray = self.userPhotosArray
            }
        })
    }
    
    func getResults(searchQuery: String) {
        filteredPhotoArray.removeAll()
        self.collectionView.reloadData()
        for photo in arrayWithData {
            let photoUserString = photo.value!["user"] as! String
             print("photo user is: \(photoUserString) and query is: \(searchQuery)")
            if photoUserString.containsString(searchQuery) || searchQuery == "" {
                let decodedData = NSData(base64EncodedString: (photo.value["photoString"] as? String)!, options: NSDataBase64DecodingOptions())
                let decodedImage = UIImage(data: decodedData!)
                self.filteredPhotoArray.insert(decodedImage!, atIndex: 0)
                print("added photo: \(self.filteredPhotoArray[0])")
                self.collectionView.reloadData()
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        getResults(searchText)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    //MARK: CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPhotoArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pizza", forIndexPath: indexPath) as! PhotoCollectionViewCell
        let photo = filteredPhotoArray[indexPath.row]
        cell.photoView.image = photo
        
        
        return cell
    }
    
    
    
    
}
