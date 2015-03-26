//
//  DataProvider.swift
//  Air
//
//  Created by Said Sikira on 3/21/15.
//  Copyright (c) 2015 Said Sikira. All rights reserved.
//

import Foundation

class StationsData {
    class func getStations(completion:(Array<Station>?,Bool) -> Void) {
        var tempStations = Array<Station>()
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        request(.GET, "http://52.10.176.0:8080/stations")
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
                        //                        station.pollution_index = Int(arc4random_uniform(100))
                        station.pollution_index_label = stationJSON[i]["pollution_index_label"].stringValue
                        station.region = stationJSON[i]["region"].stringValue
                        station.visible = stationJSON[i]["visible"].boolValue
                        println(station.visible)
                        station.flowId = stationJSON[i]["flow_id"].stringValue
                        
                        if station.visible {
                            tempStations.append(station)
                            if let value = appDelegate.stationSettings[station.flowId!] {
                            } else {
                                appDelegate.stationSettings.updateValue(true, forKey: station.flowId!)
                            }
                            if i == 0 {
                                var notification = UILocalNotification()
                                notification.timeZone = NSTimeZone.defaultTimeZone()
                                var dateTime = NSDate()
                                notification.fireDate = dateTime
                                notification.alertAction = "Show me"
                                notification.applicationIconBadgeNumber = station.pollution_index
                                UIApplication.sharedApplication().scheduleLocalNotification(notification)
                            }
                        }
                        
                        
                        
                    }
                    println(tempStations.count)
                    completion(tempStations,true)
                }
        }
    }
    
    class func sendDeviceToken(token: String) {
        var mutableRequest = NSMutableURLRequest(URL: NSURL(string: "https://api.flowthings.io/v0.1/anes/drop/f551020240cf28ddd51def8f9")!)
        
        mutableRequest.addValue("jdWjAAnbn4WHFmkHxKQjuqDrJK7oqrrI", forHTTPHeaderField: "X-Auth-Token")
        mutableRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableRequest.HTTPMethod = "POST"
        var params : JSON = ["elems" : ["token" : token]]
        var req = ParameterEncoding.JSON.encode(mutableRequest, parameters: params.dictionaryObject).0
        
        request(req).responseJSON {
            request,response,data,error in
            println(data)
        }
    }
}