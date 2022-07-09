//
//  MapViewController.swift
//  Guidebook App(Realm)
//
//  Created by Burak AKCAN on 7.07.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    var place:Place?
    var locationManager:CLLocationManager?
    var lastKnownLocation:CLLocation?
    
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        
        //create configure location manager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager?.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager?.startUpdatingLocation()
        }
   

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager?.requestAlwaysAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Check for a place and plot pin
        if place != nil {
            plotPin(place!)
        }
    }
    
    
    func plotPin(_ p:Place){
       let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(p.lat), longitude: CLLocationDegrees(p.long))
        pin.title = p.name
        mapView.addAnnotation(pin)
        
        mapView.showAnnotations([pin], animated: true)
    }
    
    func showGeoLocationError() {
        let alert = UIAlertController(title: "Geolocaiton Error", message: "Location services turned off", preferredStyle: .alert)
        //Create Settings Button
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { action in
            let url = URL(string: UIApplicationOpenNotificationSettingsURLString)
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        //Create cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func locateTapped(_ sender: UIButton) {
        
        
        
        if CLLocationManager.locationServicesEnabled() {
            //Check authorization
            
            let status = locationManager!.authorizationStatus
            if status == .denied || status == .restricted{
                //show error popup
                showGeoLocationError()
                
            }else if status == .authorizedWhenInUse || status == .authorizedAlways {
                //start geolocation user
                locationManager?.startUpdatingLocation()
                if let lastKnownLocation = lastKnownLocation {
                    mapView.setCenter(lastKnownLocation.coordinate, animated: true)
                }
            }else if status == .notDetermined {
                //Ask the user for permission
                locationManager?.requestWhenInUseAuthorization()
                
            }
        }else{
            //location services turned off
            showGeoLocationError()
        }
    }
    
    
    @IBAction func routeTapped(_ sender: UIButton) {
        guard place != nil && place!.address != nil  else{return}
        let newAddress = place!.address!.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "http://maps.apple.com/?address=" + newAddress)
        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    

}

extension MapViewController{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        if let location = location {
            //Center map
            if lastKnownLocation == nil{
            mapView.setCenter(location.coordinate, animated: true)
            }
            lastKnownLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            showGeoLocationError()
        }else if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    func locationAuthorizationStatus() -> CLAuthorizationStatus {
        let locationManager = CLLocationManager()
        var locationAuthorizationStatus : CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            locationAuthorizationStatus =  locationManager.authorizationStatus
        } else {
            // Fallback on earlier versions
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        return locationAuthorizationStatus
    }
    
  
}
