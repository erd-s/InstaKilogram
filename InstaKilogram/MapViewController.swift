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
//            print(snapshot.value)
            if let longitude = snapshot.value["longitude"] {
                print(longitude)
            } else {
                print("longitude == nil")
            }
            if(snapshot.value["longitude"] != nil && snapshot.value["latitude"] != nil && snapshot.value["location"] != nil)
            {
                let annotation:MKPointAnnotation = MKPointAnnotation()
                //print("latitude == \(snapshot.value["latitude"]) || longitude = \(snapshot.value["longitude"])")
                guard
                    let lat = snapshot.value["latitude"] as? Double,
                    let lon = snapshot.value["longitude"] as? Double
                    else
                {
                        return
                }
                //print(lat)
                annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
                annotation.title = snapshot.value["caption"] as? String
                mapView.addAnnotation(annotation)
                
                var aggregateLongitude = 0.0
                var aggregateLatitude = 0.0
                var averageLatitude = 0.0
                var averageLongitude = 0.0
                
                
                print(self.mapView.annotations)
                for annotation in mapView.annotations
                {
                    aggregateLatitude = aggregateLatitude + annotation.coordinate.latitude
                    aggregateLongitude = aggregateLongitude + annotation.coordinate.longitude
                }
                
                averageLatitude = aggregateLatitude/Double(self.mapView.annotations.count)
                averageLongitude = aggregateLongitude/Double(self.mapView.annotations.count)
                
                mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(averageLatitude, averageLongitude), MKCoordinateSpanMake(0.05, 0.05)), animated: true)

            }
            else
            {
                print("No location.")
            }
        }
        
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        
        return pin
    }
    
    
    

    
    
    

}

