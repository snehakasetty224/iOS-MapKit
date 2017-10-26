//
//  RouteViewController.swift
//  iOSMapKit
//
//  Created by Sneha Kasetty Sudarshan on 9/26/17.
//  Copyright © 2017 Sneha Kasetty Sudarshan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RouteViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var myRoute : MKRoute!
    
    var fromaddress = ""
    var toaddress = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        myMapView.delegate = self
        myMapView.showsScale = true
        myMapView.showsPointsOfInterest = true
       // myMapView.showsUserLocation = true
               let fromRequest = MKLocalSearchRequest()
               fromRequest.naturalLanguageQuery = fromaddress
        
               let activeSearch1 = MKLocalSearch(request: fromRequest)
        
                activeSearch1.start {
                    (response, error) in
                    if response == nil
                    {
                        print ("ERROR")
                    }
                    else
                    {
                        //Create data
                         var latitude = response?.boundingRegion.center.latitude
                         var longitude = response?.boundingRegion.center.longitude
                         let point1 = MKPointAnnotation()
                        point1.coordinate = CLLocationCoordinate2DMake(Double(latitude!),Double(longitude!))
                        point1.title = "Taipei"
                        self.myMapView.addAnnotation(point1)
                        
                        let toRequest = MKLocalSearchRequest()
                        toRequest.naturalLanguageQuery = self.toaddress
                        
                        let activeSearch1 = MKLocalSearch(request: toRequest)
                        
                        activeSearch1.start {
                            (response, error) in
                            if response == nil
                            {
                                print ("ERROR")
                            }
                            else
                            {
                                //Create data
                                var latitude1 = response?.boundingRegion.center.latitude
                                var longitude1 = response?.boundingRegion.center.longitude
                                let point2 = MKPointAnnotation()
                                point2.coordinate = CLLocationCoordinate2DMake(Double(latitude1!),Double(longitude1!))
                                point1.title = "san jose"
                                self.myMapView.addAnnotation(point2)
                                //Span of the map
                                self.myMapView.setRegion(MKCoordinateRegionMake(point2.coordinate, MKCoordinateSpanMake(0.7,0.7)), animated: true)
                                
                                let directionsRequest = MKDirectionsRequest()
                                let markTaipei = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point1.coordinate.latitude, point1.coordinate.longitude), addressDictionary: nil)
                                let markChungli = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
                                
                                directionsRequest.source = MKMapItem(placemark: markChungli)
                                directionsRequest.destination = MKMapItem(placemark: markTaipei)
                                
                                directionsRequest.transportType = MKDirectionsTransportType.automobile
                                let directions = MKDirections(request: directionsRequest)
                                
                                directions.calculate(completionHandler: {
                                    response, error in
                                    
                                    if error == nil {
                                        self.myRoute = response!.routes[0] as MKRoute
                                        self.myMapView.add(self.myRoute.polyline)
                                    }
                                    
                                })
                        
                    }
                }
    
         }
      }
        
    } 
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        myLineRenderer.strokeColor = UIColor.red
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    }
 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
   

}
