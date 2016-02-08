//
//  TakePhotoViewController.swift
//  InstaKilogram
//
//  Created by Yemi Ajibola on 2/6/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import MobileCoreServices

class TakePhotoViewController: UIViewController, UINavigationControllerDelegate
{
    var picker:UIImagePickerController = UIImagePickerController()
    var chosenImage:UIImage?
    
    @IBOutlet weak var sourcePicker: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool)
    {
       
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
    }
    
    @IBAction func indexChanged(sender: AnyObject)
    {
        if(self.sourcePicker.selectedSegmentIndex == 0)
        {
            
        }
        else if (self.sourcePicker.selectedSegmentIndex == 1)
        {
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(picker, animated: false, completion: nil)
        }
        else
        {
           startCameraFromViewController(self, withDelegate: self)
        }
        
    }
    
    @IBAction func onOKButtonTapped(sender: AnyObject)
    {
        
        
        
        
    }
    
    func startCameraFromViewController(viewController:UIViewController, withDelegate delegate:protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false
        {
            return false
        }
        
        let cameraController:UIImagePickerController = UIImagePickerController()
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = [kUTTypeMovie as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        presentViewController(cameraController, animated: true, completion: nil)
        
        return true
        
    }
    
    func video(videoPath: NSString, didFinishSavingWithError error:NSError?, contextInfo info:AnyObject)
    {
        var title = "Success"
        var message = "Video was saved"
        
        if let _ = error
        {
            title = "Error"
            message = "Video failed to save"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        self.chosenImage = image
        self.imageView.image = self.chosenImage
        
    }
    
    
    
}
    

extension TakePhotoViewController : UIImagePickerControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == kUTTypeMovie
        {
            let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path!)
            {
                UISaveVideoAtPathToSavedPhotosAlbum(path!, self, "video:didFinishSavingWithError:contextInfo:", nil)
            }
        }
    }

}


