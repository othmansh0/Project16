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

// Map views have annotations that weren't created by us, such as the user's location

//---------------------------------------------------------------------------------------

//Every time the map needs to show an annotation, it calls a viewFor method on its delegate

//Customizing an annotation view is like customizing a table view cell, because iOS automatically reuses annotation views. If there isn't one available to reuse, we need to create one from scratch using the MKPinAnnotationView class

//-----------------------------------------------------------------------------------------

//MKPinAnnotationView is a built-in class that draws tappable pins on the map

// We can choose from multiple map styles, such as satellite maps.

//Maps have a mapType property that lets us control this

//viewFor method that lets us control how annotation views look

import MapKit
import UIKit

//We already used Interface Builder to make our view controller the delegate for the map view, but if you want code completion to work you should also update your code to declare that the class conforms
class ViewController: UIViewController, MKMapViewDelegate {
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
        //Ask user which type of maps to show
        let ac = UIAlertController(title: "Choose a map type", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { [weak self]_ in
            self?.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = .hybrid
        }))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = .standard
        }))
        present(ac, animated: true)
        
    }
    
  
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //make sure our annotation is a capital else return nil
        //If the annotation isn't from a capital city, it must return nil so iOS uses a default view.
        guard annotation is Capital else { return nil }
        //set reuse identifier
        //Define a reuse identifier. This is a string that will be used to ensure we reuse annotation views as much as possible
        let identifier = "Capital"
        
        //Try to dequeue an annotation view from the map view's pool of unused views
        //Try typecasting the return value from dequeueReusableAnnotationView() so that it's an MKPinAnnotationView
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        
        
        //If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //To show info in a bubble
            annotationView?.canShowCallout = true
            
            //Create a new UIButton using the built-in .detailDisclosure type. This is a small blue "i" symbol with a circle around it
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            //If it can reuse a view, update that view to use a different annotation
            //so if we have annotation in a deque queue use it  without new annotation
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = .green
        return annotationView
    }
    
    //you don't need to use addTarget() to add an action to the button, because you'll automatically be told by the map view using a calloutAccessoryControlTapped method
    //When this method is called, you'll be told what map view sent it (we only have one, so that's easy enough), what annotation view the button came from (this is useful), as well as the button that was tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //make sure annotation is capital
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
        
    }


}

