//
//  MapViewController.swift
//  iOSMapKit
//
//  Created by Sneha Kasetty Sudarshan on 9/26/17.
//  Copyright © 2017 Sneha Kasetty Sudarshan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    
    var fromaddress = ""
    var toaddress = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("this is the seconvc  ", fromaddress)
        print ("this is the seconvc  ", toaddress)

        let activityIndiactor = UIActivityIndicatorView()
        activityIndiactor.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndiactor.center = self.view.center
        activityIndiactor.hidesWhenStopped = true
        activityIndiactor.startAnimating()
        
        self.view.addSubview(activityIndiactor)
        
        let fromRequest = MKLocalSearchRequest()
        fromRequest.naturalLanguageQuery = fromaddress
        
        let activeSearch = MKLocalSearch(request: fromRequest)
        
        //remove annotation
        let annotation = self.myMapView.annotations
        self.myMapView.removeAnnotations(annotation)
        
        activeSearch.start { (response, error) in
            if response == nil
            {
                print ("ERROR")
            }
            else
            {
              
                //Create data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation1 = MKPointAnnotation()
                annotation1.title = "From"
                annotation1.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myMapView.addAnnotation(annotation1)
            }
            
        }
        
        let toRequest = MKLocalSearchRequest()
        toRequest.naturalLanguageQuery = toaddress
        
        let activeSearch1 = MKLocalSearch(request: toRequest)
        
        activeSearch1.start { (response, error) in
            if response == nil
            {
                print ("ERROR")
            }
            else
            {
               
                //Create data
                let latitude1 = response?.boundingRegion.center.latitude
                let longitude1 = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation2 = MKPointAnnotation()
                annotation2.title = "To"
                annotation2.coordinate = CLLocationCoordinate2DMake(latitude1!, longitude1!)
                self.myMapView.addAnnotation(annotation2)
                
                //Span of the map
                self.myMapView.setRegion(MKCoordinateRegionMake(annotation2.coordinate, MKCoordinateSpanMake(0.7,0.7)), animated: true)
           
            }
            
        }
        
        //[myMapView .showAnnotations(annotations, animated: true)]
        
    }

    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
 
    

  

}
