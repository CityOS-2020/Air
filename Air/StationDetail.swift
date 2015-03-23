//
//  StationDetail.swift
//  Air
//
//  Created by Said Sikira on 3/22/15.
//  Copyright (c) 2015 Said Sikira. All rights reserved.
//

import UIKit

class StationDetail: UIView {

    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var flowID = String()
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    @IBOutlet weak var FeaturedButton: UIButton!
    
    @IBAction func featuredButtonAction(sender: AnyObject) {
        appDelegate.changedSomething = true
        if let value = appDelegate.stationSettings[flowID] {
            if value {
                appDelegate.stationSettings.updateValue(!value, forKey: flowID)
                self.FeaturedButton.setImage(UIImage(named: "plus"), forState: .Normal)
            } else {
                appDelegate.stationSettings.updateValue(!value, forKey: flowID)
                self.FeaturedButton.setImage(UIImage(named: "minus"), forState: .Normal)
            }
        }
    }
    
    var station : Station? {
        didSet {
            valueLabel.text = String(station!.pollution_index)
            descLabel.text = station?.pollution_index_label
            stationNameLabel.text = station?.display_name
            regionLabel.text = station?.region
            flowID = station!.flowId!
        }
    }
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        heightConstraint.constant = 0.5
        
    }
}
