//
//  StationGaugeView.swift
//  Air
//
//  Created by Said Sikira on 3/21/15.
//  Copyright (c) 2015 Said Sikira. All rights reserved.
//

import UIKit

class StationGaugeView: UIView {

    @IBOutlet weak var gaugeBackgroundView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var activityImage: UIImageView!
    
    var stationName : String?
    var gauge = WMGaugeView()
    
    var station : Station? {
        didSet {
            self.setGaugeValue(Double(station!.pollution_index))
            self.descLabel.text = station!.pollution_index_label
            self.stationName = station!.display_name
        }
    }
    
    func display() {
        let width = gaugeBackgroundView.frame.width
        let height = gaugeBackgroundView.frame.height
        
        self.gaugeBackgroundView.backgroundColor = UIColor.whiteColor()
        self.gauge = WMGaugeView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        gauge.maxValue = 100
        gauge.scaleDivisions = 10
        gauge.scaleSubdivisions = 5
        gauge.scaleStartAngle = 60
        gauge.scaleEndAngle = 300
        gauge.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleVeryHigh
        gauge.backgroundColor = UIColor.clearColor()
        gauge.scaleFont = UIFont(name: "HelveticaNeue-Thin", size: 0.055)
        gauge.tintColor = UIColor.whiteColor()
        gauge.showRangeLabels = true
        gauge.showUnitOfMeasurement = true
        gauge.needleStyle = WMGaugeViewNeedleStyleFlatThin
        gauge.needleWidth = 0.01
        gauge.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain
        gauge.needleScrewRadius = 0.04
        gauge.showScale = true
        gauge.showScaleShadow = false
        self.setGaugeValue(0)
        self.gaugeBackgroundView.addSubview(gauge)
    }
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension StationGaugeView {
    
    func setGaugeValue(value: Double) {
        var stringValue:String = String(format:"%.0f", value)
        self.valueLabel.text = stringValue
        
        switch value {
        case -1...25:
            gauge.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleVeryLow
            self.activityImage.image = UIImage(named: "hiking")
            self.valueLabel.textColor = UIColor(red:0.45, green:0.75, blue:0.45, alpha:1)
        case 25...50:
            gauge.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleLow
            self.activityImage.image = UIImage(named: "bike")
            self.valueLabel.textColor = UIColor(red:0.71, green:0.85, blue:0.46, alpha:1)
        case 50...75:
            gauge.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleMedium
            self.activityImage.image = UIImage(named: "nobaby")
            self.valueLabel.textColor = UIColor(red:0.95, green:0.83, blue:0.4, alpha:1)
        case 75...100:
            gauge.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleHigh
            self.activityImage.image = UIImage(named: "high")
            self.valueLabel.textColor = UIColor(red:0.92, green:0.55, blue:0.29, alpha:1)
        default:
            gauge.innerBackgroundStyle = WMGaugeViewInnerBackgroundStyleVeryHigh
        }
        
        gauge.setValue(Float(value), animated: true, duration: 1.0)
        
        
        
    }
}
