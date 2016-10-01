//
//  File.swift
//  MaMadeIt-Swift
//
//  Created by Joaquim Patrick Ramos Grilo on 2015-12-24.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import GoogleMaps

class DemoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: -33.868,
            longitude:151.2086, zoom:6)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera:camera)
        
        let marker = GMSMarker()
        marker.position = (camera?.target)!
        marker.snippet = "Hello World"
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        
        self.view = mapView
    }
}
