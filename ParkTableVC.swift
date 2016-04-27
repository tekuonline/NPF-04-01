//
//  ParkTableVC.swift
//  NPF-4
//
//  Created by Tek Nepal on 4/21/16.
//  Copyright © 2016 Tek Nepal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ParkTableVC: UITableViewController {
  
     var location:CLLocation?

    var parkList = Parks()
    var mapVC:MapVC!
    
    var parks : [Park] {                    //front end for LandmarkList model object
        get {
            return self.parkList.parkList!
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //parks.sortInPlace({$1.getParkName() < $0.getParkName()})
         parks.sortInPlace({$0.getParkName() < $1.getParkName()})
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return parks.count
    }
    
    
    
    @IBAction func sor(sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            parks.sortInPlace({$0.getParkName() < $1.getParkName()})
            self.tableView.reloadData()
            break;
        case 1:
            parks.sortInPlace({$1.getParkName() < $0.getParkName()})
            self.tableView.reloadData()
            break;
        case 2:
            parks.sortInPlace({$0.distance() < $1.distance()})
           self.tableView.reloadData()
            break;
        default:
            break;
        }

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LandmarkCell", forIndexPath: indexPath)
        let landmark = parks[indexPath.row]

        cell.textLabel?.text = landmark.getParkName()
        
        cell.detailTextLabel?.text = (String(landmark.distance())) + " Miles"
       
        cell.accessoryType = .DisclosureIndicator
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let landmark = parks[indexPath.row]
        let detailVC = LandMarkDetailGroupedTableVC(style: .Grouped)
        detailVC.parks = parks
        detailVC.title = landmark.title
       // detailVC.parkList = self.parkList
        detailVC.mapVC = mapVC
        
        //detailVC.zoomDeligate = mapVC
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
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
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    
    
}

