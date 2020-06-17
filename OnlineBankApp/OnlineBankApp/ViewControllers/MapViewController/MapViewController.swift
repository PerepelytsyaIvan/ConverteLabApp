//
//  MapViewController.swift
//  OnlineBankApp
//
//  Created by Dream Store on 31.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    //MARK: - Properties
    var adress = String()
    private var geocoder = CLGeocoder()
   
    //MARK: - @IBOutlet
    @IBOutlet private weak var mapView: MKMapView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        geocoder.geocodeAddressString(adress) {[weak self] (plecemarks, error) in
            if error != nil {
                print(error as Any)
            }
            
            if plecemarks != nil {
                if let placemark = plecemarks?.first {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = placemark.location!.coordinate
                    self?.mapView.showAnnotations([annotation], animated: true)
                    self?.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
}
