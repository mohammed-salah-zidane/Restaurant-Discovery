//
//  MapViewController.swift
//  ZidaneFood
//
//  Created by Mohamed Salah Zidane on 9/10/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet var mapView:MKMapView!
    var restaurant : Restaurant!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        mapView.delegate = self
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location) { (placemarks, error) in
            if error != nil {
                print(error!)
            }else {
                if let placemarks = placemarks {
                    let placemark = placemarks[0]
                    
                    let annotation = MKPointAnnotation()
                   
                     annotation.title = self.restaurant.name
                     annotation.subtitle = self.restaurant.type
                    if let location = placemark.location{
                        annotation.coordinate = location.coordinate
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation,animated: true)
                        
                    }
                }
            }
        }
      
        // Do any additional setup after loading the view.
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self)
        {
            return nil
        }
        
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil
        {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x:0, y:0 ,width: 60 ,height:60))
        leftIconView.image = UIImage(named: restaurant.image)
        annotationView?.rightCalloutAccessoryView = leftIconView
    
        annotationView?.pinTintColor = UIColor.orange
        
        return annotationView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
