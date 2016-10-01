/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.*/

import UIKit
import Parse
import GoogleMaps

class ViewController: UIViewController,  UITextFieldDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate

{
    
    @IBOutlet var searchMap: UISearchBar!
    
    @IBOutlet var Open: UIBarButtonItem!
    
    @IBOutlet var mapOutlet: MKMapView!
    
    var foodRequestActive = false
    
    var locationManager:CLLocationManager!
    
    var latitude: CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    let initialLocation = CLLocation(latitude: 43.6525, longitude: -79.3686)
    let searchRadius: CLLocationDistance = 2000
    
   
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, searchRadius * 1.0, searchRadius * 1.0)
        mapOutlet.setRegion(coordinateRegion, animated: true)
        
        //if self.revealViewController() != nil {
            Open.target = self.revealViewController()
            Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
           
       // }

       
        }
    
    func searchBarSearchButtonClicked(_ searchMap: UISearchBar){
        //1
        searchMap.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        if self.mapOutlet.annotations.count != 0{
            annotation = self.mapOutlet.annotations[0]
            self.mapOutlet.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchMap.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchMap.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapOutlet.centerCoordinate = self.pointAnnotation.coordinate
            self.mapOutlet.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        
        self.latitude = location.latitude
        self.longitude = location.longitude
        
        print("locations = \(location.latitude) \(location.longitude)")
        
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapOutlet.setRegion(region, animated: true)
        
        self.mapOutlet.removeAnnotations(mapOutlet.annotations)
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "Your location"
        self.mapOutlet.addAnnotation(objectAnnotation)
        
    }
    

}


