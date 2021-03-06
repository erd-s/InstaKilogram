//
//  TakePhotoViewController.swift
//  InstaKilogram
//
//  Created by Yemi Ajibola on 2/6/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import Firebase
import MobileCoreServices
import MapKit


class TakePhotoViewController: UIViewController, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextViewDelegate {
    //MARK: Properties
    var chosenImage:UIImage?
    var originalImage:UIImage!
    var editedImage:UIImage!
    var imageToSave:UIImage!
    var locationManager:CLLocationManager!
    var photo:Photo!
    
    //MARK: Outlets
    @IBOutlet weak var sourcePicker: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var locationButton: UIButton!
    
    //MARK: View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        self.okButton.enabled = false
        self.captionTextView.userInteractionEnabled = false
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //MARK: Keyboard
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    //MARK: Actions
    @IBAction func indexChanged(sender: AnyObject)
    {
        if(self.sourcePicker.selectedSegmentIndex == 0)
        {
            let libraryController = UIImagePickerController()
            libraryController.sourceType = .PhotoLibrary
            libraryController.delegate = self
            presentViewController(libraryController, animated: true, completion: nil)
            self.okButton.enabled = true
            
        }
        else if (self.sourcePicker.selectedSegmentIndex == 1) {
            startCameraFromViewController(self, withDelegate: self)
        }
        else {
            startCameraFromViewController(self, withDelegate: self)
        }
    }
    
    @IBAction func onOKButtonTapped(sender: AnyObject) {
        let locationAlert = UIAlertController(title: "Add a Location", message: "Would you like to add a location?", preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .Default) { (action: UIAlertAction) -> Void in
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .Cancel) { (action: UIAlertAction) -> Void in
            self.photo = Photo(image: self.imageToSave, captionText: self.captionTextView.text, locationPlacemark:nil)
            self.performSegueWithIdentifier("toTabViewController", sender: self)
        }
        locationAlert.addAction(confirmAction)
        locationAlert.addAction(cancelAction)
        self.presentViewController(locationAlert, animated: true, completion: nil)
        
        performSegueWithIdentifier("toTabViewController", sender: self)
    }
    
    //MARK: Camera
    func startCameraFromViewController(viewController:UIViewController, withDelegate delegate:protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
            return false
        }
        
        let cameraController:UIImagePickerController = UIImagePickerController()
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.Camera)!
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        presentViewController(cameraController, animated: true, completion: nil)
        
        self.okButton.enabled = true
        self.captionTextView.userInteractionEnabled = true
        
        return true
    }
    
    @IBAction func onLocationButtonTapped(sender: AnyObject) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    //MARK: Location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        
        if location?.verticalAccuracy < 1000 && location?.horizontalAccuracy < 1000 {
            reverseGeocode(location!)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func reverseGeocode(location:CLLocation) {
        let geocoder:CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
            let placemark = placemarks?.first
            let address = "\(placemark!.subThoroughfare!) \(placemark!.thoroughfare!) \(placemark!.locality!)"
            
            let locationAlert = UIAlertController(title: "Set Current Location", message: "Add location: \(address)", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
                self.photo = Photo(image: self.imageToSave, captionText: self.captionTextView.text, locationPlacemark: nil)
                self.performSegueWithIdentifier("toTabViewController", sender: self)
                
            })
            let confirmAction = UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) -> Void in
                self.photo = Photo(image: self.imageToSave, captionText: self.captionTextView.text, locationPlacemark: placemark!)
                self.performSegueWithIdentifier("toTabViewController", sender: self)
                
            })
            locationAlert.addAction(cancelAction)
            locationAlert.addAction(confirmAction)
            
            self.presentViewController(locationAlert, animated: true, completion: nil)
            
        }
    }
    
    //MARK: Text View Delegate Functions
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGrayColor()
            self.resignFirstResponder()
        }
    }
}

//MARK: Image Picker
extension TakePhotoViewController : UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        dismissViewControllerAnimated(true, completion: nil)
        
        if CFStringCompare(mediaType, kUTTypeImage, .CompareCaseInsensitive) == CFComparisonResult.CompareEqualTo {
            originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        if (editedImage != nil) {
            imageToSave = editedImage
        }
        else {
            let size2 = CGSizeMake(512, 512)
            let hasAlpha = false
            let scale: CGFloat = 0.0
            UIGraphicsBeginImageContextWithOptions(size2, !hasAlpha, scale)
            originalImage.drawInRect(CGRect(origin: CGPointZero, size: size2))
            
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            imageToSave = scaledImage
        }
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        self.imageView.image = imageToSave
    }
}


