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


class TakePhotoViewController: UIViewController, UINavigationControllerDelegate
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
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.okButton.enabled = false
        self.captionTextView.userInteractionEnabled = false
        self.locationButton.userInteractionEnabled = false
       
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
            let size = CGSizeApplyAffineTransform(originalImage.size, CGAffineTransformMakeScale(0.5, 0.5))
            let hasAlpha = false
            let scale: CGFloat = 0.0
            UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
            originalImage.drawInRect(CGRect(origin: CGPointZero, size: size))
            
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


