//
//  ViewControllerDetalhesPraia.swift
//  Cariocando
//
//  Created by Mikael Schirru on 10/10/16.
//  Copyright © 2016 Mikael Schirru. All rights reserved.
//

import UIKit
import MapKit

class ViewControllerDetalhesPraia: UIViewController, CLLocationManagerDelegate {
    
    
    let locationManager = CLLocationManager()
    
    @IBOutlet var imagemPraia: UIImageView!
    
    @IBOutlet var tituloPraia: UILabel!
    
    @IBOutlet var mapPraia: MKMapView!
    
    @IBOutlet var enderecoPraia: UILabel!
    
    var dicPlace:NSDictionary?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapPraia.showsUserLocation = true
        
        if let dic = dicPlace {
            
            let name = dic["nome"] as! String
            let address = dic["endereco"] as! String
            let image = dic["image"] as? String
            
            tituloPraia.text = name
            enderecoPraia.text = address
            
            
            imagemPraia.image = UIImage(named: image!)
            
            btActionGeoCoder()
        }
        
    }
    
    func btActionGeoCoder() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(enderecoPraia.text!) { (placemarks, error) -> Void in
            
            if let placemark: CLPlacemark = placemarks?[0] {
                let location = placemark.location
                
                if let coords: CLLocationCoordinate2D = location?.coordinate {
                    print("Latitude = \(coords.latitude), Longitude = \(coords.longitude)")
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    let region = MKCoordinateRegion (center: coords, span: span)
                    self.mapPraia.setRegion(region, animated: false)
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = coords
                    pin.title = self.dicPlace!["nome"] as? String
                    pin.subtitle = self.dicPlace!["endereco"] as? String
                    self.mapPraia.addAnnotation(pin)
                }
            }
            else {
                print("Erro")
            }
        }
    }
    
    @IBAction func butdirection(_ sender: UIButton) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(enderecoPraia.text!) { (placemarks, error) -> Void in
            
            if let placemark: CLPlacemark = placemarks?[0] {
                let location = placemark.location
                
                if let coords: CLLocationCoordinate2D = location?.coordinate {
                    print("Latitude = \(coords.latitude), Longitude = \(coords.longitude)")
                    let url = URL(string: "http://maps.apple.com/maps?daddr=\(coords.latitude),\(coords.longitude))")!
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                    
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    let region = MKCoordinateRegion (center: coords, span: span)
                    self.mapPraia.setRegion(region, animated: false)
                }
            }
            else {
                print("Erro")
            }
        }
        
        
        
    }
}
