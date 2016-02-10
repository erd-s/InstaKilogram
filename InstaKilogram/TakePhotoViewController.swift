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


class TakePhotoViewController: UIViewController, UINavigationControllerDelegate, CLLocationManagerDelegate
{
    //var picker:UIImagePickerController = UIImagePickerController()
    var chosenImage:UIImage?
    
    @IBOutlet weak var sourcePicker: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var locationButton: UIButton!
    
    
    var originalImage:UIImage!
    var editedImage:UIImage!
    var imageToSave:UIImage!
    var locationManager:CLLocationManager!
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.okButton.enabled = false
        self.captionTextView.userInteractionEnabled = false
        self.locationButton.enabled = false
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
       
    }
    
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
        else if (self.sourcePicker.selectedSegmentIndex == 1)
        {
            startCameraFromViewController(self, withDelegate: self)
        }
        else
        {
            startCameraFromViewController(self, withDelegate: self)
        }
        
    }
    
    @IBAction func onOKButtonTapped(sender: AnyObject)
    {
        //print("OK Button tapped")
        Photo(image: self.imageToSave, captionText: self.captionTextView.text)
        
        if self.captionTextView.text != nil
        {
            
        }
        //print("I have finished creating a photo")
        performSegueWithIdentifier("toTabViewController", sender: self)
        
    }
    
    func startCameraFromViewController(viewController:UIViewController, withDelegate delegate:protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false
        {
            return false
        }
        
        let cameraController:UIImagePickerController = UIImagePickerController()
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.Camera)!
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        presentViewController(cameraController, animated: true, completion: nil)
        
        self.okButton.enabled = true
        self.locationButton.enabled = true
        self.captionTextView.userInteractionEnabled = true
        
        return true
        
    }
    
    
    @IBAction func onLocationButtonTapped(sender: AnyObject)
    {
        // Get user's location
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.first
        
        if location?.verticalAccuracy < 1000 && location?.horizontalAccuracy < 1000
        {
            reverseGeocode(location!)
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func reverseGeocode(location:CLLocation)
    {
        let geocoder:CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
            let placemark = placemarks?.first
            let address = "\(placemark!.subThoroughfare!) \(placemark!.thoroughfare!) \(placemark!.locality!)"
            
            let locationAlert = UIAlertController(title: "Set Current Location", message: "Add location :\(address)", preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let confirmAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            locationAlert.addAction(cancelAction)
            locationAlert.addAction(confirmAction)
            
            self.presentViewController(locationAlert, animated: true, completion: nil)
            
        }
    }
    
//    func video(videoPath: NSString, didFinishSavingWithError error:NSError?, contextInfo info:AnyObject)
//    {
//        var title = "Success"
//        var message = "Video was saved"
//        
//        if let _ = error
//        {
//            title = "Error"
//            message = "Video failed to save"
//        }
//        
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
    
    
    
}
    

extension TakePhotoViewController : UIImagePickerControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        dismissViewControllerAnimated(true, completion: nil)

        if CFStringCompare(mediaType, kUTTypeImage, .CompareCaseInsensitive) == CFComparisonResult.CompareEqualTo
        {
            //editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
        }
        if (editedImage != nil)
        {
            imageToSave = editedImage
        }
        else
        {
            let size2 = CGSizeMake(512, 512)
            
           // let size = CGSizeApplyAffineTransform(originalImage.size, CGAffineTransformMakeScale(0.5, 0.5))
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
        
//        if mediaType == kUTTypeMovie
//        {
//            let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path
//            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path!)
//            {
//                UISaveVideoAtPathToSavedPhotosAlbum(path!, self, "video:didFinishSavingWithError:contextInfo:", nil)
//            }
//        }
//        else
//        {
//            self.chosenImage =
//        }
    }

}


