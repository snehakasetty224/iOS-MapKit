//
//  ViewController.swift
//  iOSMapKit
//
//  Created by Sneha Kasetty Sudarshan on 9/26/17.
//  Copyright © 2017 Sneha Kasetty Sudarshan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fromlabel: UITextField!
    @IBOutlet weak var fromStreet: UITextField!
    @IBOutlet weak var fromCity: UITextField!
    @IBOutlet weak var fromState: UITextField!
    @IBOutlet weak var fromZip: UITextField!
   
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var toView: UIView!
    
    @IBOutlet weak var tolabel: UITextField!
    @IBOutlet weak var toStreet: UITextField!
    @IBOutlet weak var toCity: UITextField!
    @IBOutlet weak var toState: UITextField!
    @IBOutlet weak var toZip: UITextField!
    
    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromView.layer.borderWidth = 5
        fromView.layer.borderColor = UIColor.white.cgColor
        toView.layer.borderWidth = 5
        toView.layer.borderColor = UIColor.white.cgColor
        
        self.fromlabel.delegate = self
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if (segue.identifier! == "map")
        {
        let secondcontroller = segue.destination as! MapViewController
        let from = "\(fromlabel.text!) \(fromStreet.text!) \(fromCity.text!)\(fromState.text!)\(fromZip.text!)"
        let to = "\(tolabel.text!) \(toStreet.text!) \(toCity.text!) \(toState.text!) \(toZip.text!)"
        secondcontroller.fromaddress = from
        secondcontroller.toaddress = to
        }
        else if(segue.identifier! == "route")
       {
        let secondcontroller1 = segue.destination as! RouteViewController
        let from = "\(fromlabel.text!) \(fromStreet.text!) \(fromCity.text!)\(fromState.text!)\(fromZip.text!)"
        let to = "\(tolabel.text!) \(toStreet.text!) \(toCity.text!) \(toState.text!) \(toZip.text!)"
        secondcontroller1.fromaddress = from
        secondcontroller1.toaddress = to

        }
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 
    
    @IBAction func mapButton(_ sender: Any) {
        
        performSegue(withIdentifier: "map", sender: self)
       
    }
    
    @IBAction func routeButton(_ sender: Any) {
        
        performSegue(withIdentifier: "route", sender: self)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

