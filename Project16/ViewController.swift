//
//  ViewController.swift
//  Project16
//
//  Created by othman shahrouri on 9/17/21.
//

//Annotations are objects that contain a title(otpional), a subtitle(otpional)and a position
//which defines a place on a map

//Position has new type called CLLocationCoordinate2D

//which is a structure that holds a latitude and longitude for where the annotation should be placed

//Map annotations are described not as a class, but as a protocol

//if we want to conform to the MKAnnotation protocol, which is the one we need to adopt in order to create map annotations, it states that we must have a coordinate in our annotation.

//With map annotations, you can't use structs, and you must inherit from NSObject

import MapKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Create annotations using Capital class
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london,oslo,paris,rome,washington])
    }


}

