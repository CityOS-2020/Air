//
//  StationTableViewCell.swift
//  Air
//
//  Created by Said Sikira on 3/22/15.
//  Copyright (c) 2015 Said Sikira. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {

    @IBOutlet weak var pollutionValueLabel: UILabel!
    @IBOutlet weak var cityIndexLabel: UILabel!
    @IBOutlet weak var indexBackgroundView: UIView!
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    var station: Station? {
        didSet {
            self.pollutionValueLabel.text = String(station!.pollution_index)
            self.stationNameLabel.text = station!.display_name
            self.regionLabel.text = station!.region
            
            switch station!.pollution_index {
            case -1...25:
                self.indexBackgroundView.backgroundColor = UIColor(red:0.45, green:0.75, blue:0.45, alpha:1)
            case 25...50:
                self.indexBackgroundView.backgroundColor = UIColor(red:0.5, green:0.82, blue:0.51, alpha:1)
            case 50...75:
                self.indexBackgroundView.backgroundColor = UIColor(red:0.91, green:0.55, blue:0.32, alpha:1)
            case 75...100:
                self.indexBackgroundView.backgroundColor = UIColor(red:0.8, green:0.26, blue:0.23, alpha:1)
            default:
                println("wtf is going on")
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
