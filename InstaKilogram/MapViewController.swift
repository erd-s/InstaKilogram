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
            if(snapshot.value["longitude"] != nil)
            {
                let annotation:MKPointAnnotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(snapshot.value["latitude"] as! Double, snapshot.value["longitude"] as! Double)
                annotation.title = snapshot.value["caption"] as? String
                mapView.addAnnotation(annotation)
            }
        }
        
        var aggregateLongitude = 0.0
        var aggregateLatitude = 0.0
        var averageLatitude = 0.0
        var averageLongitude = 0.0
        
        for annotation in mapView.annotations
        {
            aggregateLatitude = aggregateLatitude + annotation.coordinate.latitude
            aggregateLongitude = aggregateLongitude + annotation.coordinate.longitude
        }
        
        averageLatitude = aggregateLatitude/Double(self.mapView.annotations.count)
        averageLongitude = aggregateLongitude/Double(self.mapView.annotations.count)
        
        mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(averageLatitude, averageLongitude), MKCoordinateSpanMake(0.05, 0.05)), animated: true)
    
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        
        return pin
    }
    
    
    

    
    
    

}

