//
//  RestaurantDetailViewController.swift
//  ZidaneFood
//
//  Created by Mohamed Salah Zidane on 8/30/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var DetailTableView: UITableView!
    
    @IBOutlet var restaurantImageView :UIImageView!
    var restaurant : Restaurant!
    @IBOutlet var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!RestaurantDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text =  restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text =  restaurant.location
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phone
        case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = restaurant.isVisited ? "yes, I have been here before \(restaurant.rating)" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    @IBAction func close(segue:UIStoryboardSegue){
        print("its back")
    }
    
    @IBAction func ratingButtonTapped(segue: UIStoryboardSegue)
    {
        if let rating = segue.identifier{
            restaurant.isVisited = true
            switch rating {
            case "great" : restaurant.rating = "Absolutely love it! Must try."
            case "good"  : restaurant.rating = "Pretty good"
            case "dislike" : restaurant.rating = "I don't like it."
            default : break
            }
        }
        DetailTableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = restaurant.name

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        restaurantImageView.image = UIImage(named: restaurant.image)
        DetailTableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.2)
      //  DetailTableView.tableFooterView = UIView(frame: CGRect.zero)
        DetailTableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.8)
        DetailTableView.estimatedRowHeight = 36.0
        DetailTableView.rowHeight = UITableViewAutomaticDimension
    
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location) { (placemarks, error) in
            if error != nil {
                print(error!)
            }else{
                if let placemarks = placemarks{
                    let placemark = placemarks[0]
                    
                    let annotation = MKPointAnnotation()
                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate
                        self.mapView.addAnnotation(annotation)
                        
                        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 200, 200)
                        self.mapView.setRegion(region, animated: false)
                    }
                }
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showMap(){
        performSegue(withIdentifier: "showMap", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showReview"{
            let destination = segue.destination as! ReviewViewController
            destination.restaurant  = restaurant
        }else if segue.identifier == "showMap"{
            let destination = segue.destination as! MapViewController
            destination.restaurant = restaurant
        }
    }
    

}
