//
//  ViewControllerNearBy.swift
//  Cariocando
//
//  Created by Mikael Schirru on 10/10/16.
//  Copyright © 2016 Mikael Schirru. All rights reserved.
//

import UIKit
import MapKit

class ViewControllerNearBy: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var labelendereco: UILabel!
    
    @IBOutlet var MapNearBy: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var dicPlace:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    self.locationManager.delegate = self
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
    
    self.MapNearBy.showsUserLocation = true
    
    if let dic = dicPlace {
        
        let address = dic["endereco"] as! String
        
        labelendereco.text = address


        btActionGeoCoder()
    }
    
}
    func btActionGeoCoder() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(labelendereco.text!) { (placemarks, error) -> Void in
            
            if let placemark: CLPlacemark = placemarks?[0] {
                let location = placemark.location
                
                if let coords: CLLocationCoordinate2D = location?.coordinate {
                    print("Latitude = \(coords.latitude), Longitude = \(coords.longitude)")
                    print(coords)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    let region = MKCoordinateRegion (center: coords, span: span)
                    self.MapNearBy.setRegion(region, animated: false)
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = coords
                    pin.title = self.dicPlace!["nome"] as? String
                    pin.subtitle = self.dicPlace!["endereco"] as? String
                    self.MapNearBy.addAnnotation(pin)
                }
            }
            else {
                print("Erro")
            }
        }
    }




}
