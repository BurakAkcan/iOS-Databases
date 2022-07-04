//
//  MapViewController.swift
//  Guidebook App
//
//  Created by Burak AKCAN on 1.07.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var place:Place?

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        if place != nil {
        
        //Create CLLocation2D
       let location = CLLocationCoordinate2D(latitude: place!.lat, longitude: place!.long)
        
        //Create pin
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        
        //Add it map
        mapView.addAnnotation(pin)
        
        //Create Region to Zoom
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        }
    }
    

    

}
