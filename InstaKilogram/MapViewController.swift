//
//  MapViewController.swift
//  InstaKilogram
//
//  Created by Yemi Ajibola on 2/11/16.
//  Copyright © 2016 mm. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class MapViewController: UIViewController, MKMapViewDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    var currentPhotoData:[FDataSnapshot]!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for snapshot in currentPhotoData
        {
            //let annotation = snapshot[""]
        }
    
    }
    
    
    

    
    

}

