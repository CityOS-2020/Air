//
//  DataProvider.swift
//  Air
//
//  Created by Said Sikira on 3/21/15.
//  Copyright (c) 2015 Said Sikira. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StationsData {
    class func getStations(completion:(Array<Station>?,Bool) -> Void) {
        var tempStations = Array<Station>()
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        Alamofire.request(.GET, "https://api.myjson.com/bins/40dfv")
            .responseJSON {
                request,response,data,error in
                if error != nil {
                    println(error?.localizedDescription)
                    completion(nil,false)
                } else {
                    
                    let stationJSON = JSON(data!)
                    for i in Range(start: 0, end: stationJSON.count) {
                        var station = Station()
                        station.display_name = stationJSON[i]["display_name"].stringValue
                        station.identifier = stationJSON[i]["identifier"].stringValue
                        station.latitude = stationJSON[i]["latitude"].doubleValue
                        station.longitude = stationJSON[i]["longitude"].doubleValue
                        station.pollution_index = stationJSON[i]["pollution_index"].intValue
                        station.pollution_index_label = stationJSON[i]["pollution_index_label"].stringValue
                        station.region = stationJSON[i]["region"].stringValue
                        station.visible = stationJSON[i]["visible"].boolValue
                        station.flowId = stationJSON[i]["flow_id"].stringValue
                        
                        if station.visible {
                            tempStations.append(station)
                            if let value = appDelegate.stationSettings[station.flowId!] {
                            } else {
                            if i == 0 { appDelegate.stationSettings.updateValue(true, forKey: station.flowId!)}
                            else { appDelegate.stationSettings.updateValue(false, forKey: station.flowId!) }
                            }
                        }
                        
                    }
                    completion(tempStations,true)
                }
        }
    }
}