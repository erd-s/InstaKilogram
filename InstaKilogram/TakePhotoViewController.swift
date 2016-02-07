//
//  TakePhotoViewController.swift
//  InstaKilogram
//
//  Created by Yemi Ajibola on 2/6/16.
//  Copyright © 2016 JJones. All rights reserved.
//

import UIKit
import MobileCoreServices

class TakePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
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
        
        picker.delegate = self
       
        
        
       
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
            picker.cameraDevice = UIImagePickerControllerCameraDevice.Front
           // picker.cameraDevice.takeVideo()
        }
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imageView.image = chosenImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
