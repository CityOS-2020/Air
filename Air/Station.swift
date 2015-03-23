//
//  Station.swift
//  Air
//
//  Created by Said Sikira on 3/17/15.
//  Copyright (c) 2015 Said Sikira. All rights reserved.
//

import Foundation
import MapKit
import Alamofire
import SwiftyJSON

class Station : NSObject {
    var display_name : String = ""
    var identifier : String?
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var pollution_index = Int()
    var region : String?
    var visible : Bool = false
    var pollution_index_label : String = ""
    var flowId : String?
    
    var coordinate : CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }
}

class StationMarker : GMSMarker {
    var station : Station
    
    init(fromStation station: Station) {
        self.station = station
        super.init()
        position = station.coordinate
        switch station.pollution_index {
        case 0...25:
            icon = UIImage(named: "marker-verylow")
        case 25...50:
            icon = UIImage(named: "marker-low")
        case 50...75:
            icon = UIImage(named: "marker-medium")
        case 50...75:
            icon = UIImage(named: "marker-high")
        case 75...100:
            icon = UIImage(named: "marker-vhigh")
        default:
            println("wtf is going on")
        }
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
    
}