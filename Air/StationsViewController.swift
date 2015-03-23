//
//  StationsViewController.swift
//  Air
//
//  Created by Said Sikira on 3/18/15.
//  Copyright (c) 2015 Said Sikira. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController, UIScrollViewDelegate {
    
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    @IBOutlet weak var stationsScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var gatheringLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var currentStationName : String?
    var newStations = Array<Station>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 18)!,  NSForegroundColorAttributeName: UIColor.blackColor()]
        
        self.stationsScrollView.delegate = self
        self.pageControl.numberOfPages = 0
        
        
        StationsData.getStations {
            newstations,success in
            if success {
                self.appDelegate.stations = newstations!
                self.configureStations()
                self.currentStationName = self.appDelegate.stations[0].display_name
                self.title = self.currentStationName
                self.appDelegate.sortStations()
            } else {
                UIView.animateWithDuration(0.4) { animations in
                    self.loadingIndicator.alpha = 0
                    self.gatheringLabel.text = "No internet connection"
                    self.navigationItem.leftBarButtonItem = nil
                    self.navigationItem.rightBarButtonItem = nil
                }
            }
        }
    }
    
    func configureStations() {
        let width = self.view.frame.width
        let height = stationsScrollView.frame.height
        
        var pageCounter = Int()
        
        for (key,value) in appDelegate.stationSettings {
            if value { pageCounter++ }
        }
        
        self.pageControl.numberOfPages = pageCounter
        let scrollWidth = width * CGFloat(pageCounter)
        self.stationsScrollView.contentSize = CGSize(width: scrollWidth, height: height)
        
        newStations.removeAll(keepCapacity: false)
        for station in appDelegate.stations {
            if let value = appDelegate.stationSettings[station.flowId!] {
                if value { newStations.append(station) }
            }
        }
        
        for i in Range(start: 0, end: newStations.count) {
            let station = newStations[i]
            
            let x = width * CGFloat(i)
            var stationView = UIView.loadFromNibNamed("StationGaugeView") as StationGaugeView
            stationView.display()
            stationView.station = station
            stationView.frame = CGRect(x: x, y: 0, width: width, height: height)
            stationView.alpha = 0
            self.stationsScrollView.addSubview(stationView)
            
            UIView.animateWithDuration(0.4) { animations in
                stationView.alpha = 1
                self.loadingIndicator.alpha = 0
                self.gatheringLabel.alpha = 0
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if appDelegate.stations.count > 0 {
            currentStationName = newStations[pageControl.currentPage].display_name
            self.title = currentStationName
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if appDelegate.changedSomething {
            self.stationsScrollView.alpha = 0
            self.configureStations()
            UIView.animateWithDuration(0.4) {
                animations in
                self.stationsScrollView.alpha = 1
            }
        }
        appDelegate.changedSomething = false
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var pageWidth = self.stationsScrollView.frame.size.width
        var fract = self.stationsScrollView.contentOffset.x / pageWidth
        var page = lround(Double(fract))
        var gaugeAtPage = self.stationsScrollView.subviews[page] as? StationGaugeView
        currentStationName = newStations[page].display_name
        self.title = currentStationName
        self.pageControl.currentPage = page
        self.stationsScrollView.contentOffset.y = 0
    }
    
}
