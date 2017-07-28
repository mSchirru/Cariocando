//
//  ViewController_DetalhesPontosTuristicos.swift
//  Cariocando
//
//  Created by Mikael Schirru on 09/10/16.
//  Copyright © 2016 Mikael Schirru. All rights reserved.
//

import UIKit
import MapKit

class ViewController_DetalhesPontosTuristicos: UIViewController, CLLocationManagerDelegate {
    
    
    let locationManager = CLLocationManager()

    
    @IBOutlet var labelNomeDetTuristico: UILabel!
    @IBOutlet var imageDetalhesTuristicos: UIImageView!
    
    @IBOutlet var labelEnderecoDet: UILabel!
    @IBOutlet var descricaoDetTuristico: UITextView!
    
    
    @IBOutlet var mapViewDet: MKMapView!
    
    var dicPlace:NSDictionary?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.mapViewDet.showsUserLocation = true
        
        if let dic = dicPlace {
            
            let name = dic["nome"] as! String
            let description = dic["descricao"] as! String
            let address = dic["endereco"] as! String
            
            let image = dic["image"] as? String
            
            descricaoDetTuristico.text = description
            labelNomeDetTuristico.text = name
            labelEnderecoDet.text = address
            
            
            imageDetalhesTuristicos.image = UIImage(named: image!)
            
            btActionGeoCoder()
        }
        
    }
    
    func btActionGeoCoder() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(labelEnderecoDet.text!) { (placemarks, error) -> Void in
            
            if let placemark: CLPlacemark = placemarks?[0] {
                let location = placemark.location
                
                if let coords: CLLocationCoordinate2D = location?.coordinate {
                    print("Latitude = \(coords.latitude), Longitude = \(coords.longitude)")
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    let region = MKCoordinateRegion (center: coords, span: span)
                    self.mapViewDet.setRegion(region, animated: false)
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = coords
                    pin.title = self.dicPlace!["nome"] as? String
                    pin.subtitle = self.dicPlace!["endereco"] as? String
                    self.mapViewDet.addAnnotation(pin)
                    
                }
            }
            else {
                print("Erro")
            }
        }
    }
    
    @IBAction func butdirection(_ sender: UIButton) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(labelEnderecoDet.text!) { (placemarks, error) -> Void in
            
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
                    self.mapViewDet.setRegion(region, animated: false)
                }
            }
            else {
                print("Erro")
            }
        }
        
        
        
    }
    
    @IBAction func LocUser(_ sender: UIButton) {
        
        
        let userLocation: MKUserLocation = self.mapViewDet.userLocation
        
        let coordinate: CLLocationCoordinate2D = userLocation.location!.coordinate
        
        
        
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000)
        
        self.mapViewDet.setRegion(region, animated: true)
        
    }
    
}
