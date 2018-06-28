//
//  TotalMapViewController.swift
//  UiTableViewController Test 02
//
//  Created by amadeus on 2018. 6. 2..
//  Copyright © 2018년 lse. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TotalMapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var totalMapView: MKMapView!
    var totalFoodStores: [FoodStore] = []
    var annotations = [MKPointAnnotation]()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMap(items: totalFoodStores)
//        let initialLocation = CLLocation(latitude: 35.168038, longitude: 129.071720)
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        
        totalMapView.showsUserLocation = true
    }
 
    
    func  viewMap(items: [FoodStore]) {
        for item in items {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(item.address , completionHandler: {
                (placemarks: [CLPlacemark]?, error: Error?) -> Void in
                if let error = error {
                    print(error)
                    return
                }
        
                if placemarks != nil {
                    let placemark = placemarks![0]
                    print(placemarks![0])
                    
                    // pin point 을 저장
                    let annotation = MKPointAnnotation()

                    if let location = placemark.location {
                        // Add annotation
                        annotation.title = item.name
                        annotation.subtitle = item.type
                        annotation.coordinate = location.coordinate
                        self.annotations.append(annotation)
                        self.totalMapView.addAnnotations(self.annotations)
        
                        // Set zoom level
//                              let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 800, 800)
//                              self.totalMapView.setRegion(region, animated: true)
                    }
                }
                self.totalMapView.showAnnotations(self.annotations, animated: true)
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        print(userLocation)
        
      let center = CLLocationCoordinate2D(latitude:35.168459, longitude: 129.07091360)
//        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        
        totalMapView.setRegion(region, animated: true)
        
        ////
        let annotation = MKPointAnnotation()
                annotation.coordinate = center
                annotation.title = "나의 현재위치"
                annotation.subtitle = "현재 위치"
        
        totalMapView.addAnnotation(annotation)
        totalMapView.selectAnnotation(annotation, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
