//
//  StationsMapViewController.swift
//  Air
//
//  Created by Said Sikira on 3/17/15.
//  Copyright (c) 2015 Said Sikira. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StationsMapViewController: UIViewController {
    
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var locationManager = CLLocationManager()
    var bounds = GMSCoordinateBounds()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 18)!,  NSForegroundColorAttributeName: UIColor.blackColor()]
        
        for station in appDelegate.stations {
            var stationMarker = StationMarker(fromStation: station)
            stationMarker.map = self.mapView
            self.bounds = bounds.includingCoordinate(station.coordinate)
            mapView.animateWithCameraUpdate(GMSCameraUpdate.fitBounds(bounds, withPadding: 180))
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension StationsMapViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
    }
}

extension StationsMapViewController : GMSMapViewDelegate {
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        if let station = marker as? StationMarker {
            for view in self.view.subviews {
                if let st = view as? StationDetail {
                    st.removeFromSuperview()
                }
            }
            var stationDetailView = UIView.loadFromNibNamed("StationDetail") as StationDetail
            stationDetailView.valueLabel.text = String(station.station.pollution_index)
            stationDetailView.descLabel.text = station.station.pollution_index_label
            stationDetailView.stationNameLabel.text = station.station.display_name
            stationDetailView.regionLabel.text = station.station.region
            stationDetailView.flowID = station.station.flowId!
            if let value = appDelegate.stationSettings[station.station.flowId!] {
                if value {
                    stationDetailView.FeaturedButton.setImage(UIImage(named: "minus"), forState: .Normal)
                } else {
                    stationDetailView.FeaturedButton.setImage(UIImage(named: "plus"), forState: .Normal)
                }
            }
            
            var w = self.view.frame.width
            stationDetailView.frame = CGRect(x: 0, y: 64, width: w, height: 64)
            self.view.addSubview(stationDetailView)
            
        }
        return true
    }
}