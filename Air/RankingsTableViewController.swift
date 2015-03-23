//
//  RankingsTableViewController.swift
//  Air
//
//  Created by Said Sikira on 3/21/15.
//  Copyright (c) 2015 Said Sikira. All rights reserved.
//

import UIKit

class RankingsTableViewController: UITableViewController {

    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var ascending = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSortButton()
        let image = UIImage(named: "oldcity")
        let view = UIImageView(image: image)
        view.contentMode = UIViewContentMode.ScaleAspectFill
        self.tableView.backgroundView = view
    }
    
    func addSortButton() {
        var markerImage = UIImage(named: "sort")
        var button = UIButton()
        button.setImage(markerImage, forState: .Normal)
        button.showsTouchWhenHighlighted = true
        button.frame = CGRect(x: 0, y: 3, width: 28, height: 28)
        button.addTarget(self, action: "sortStations", forControlEvents: .TouchUpInside)
        var markerButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = markerButton
    }
    
    func sortStations() {
        appDelegate.sortStations()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.appDelegate.sortedStations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stationCell", forIndexPath: indexPath) as StationTableViewCell

        cell.station = self.appDelegate.sortedStations[indexPath.row]
        cell.cityIndexLabel.text = String(indexPath.row + 1)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
