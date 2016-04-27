//
//  LandMarkDetailGroupedTableVC.swift
//  FavoritePlaces
//
//  Created by Tek Nepal on 4/7/16.
//  Copyright © 2016 Tek Nepal. All rights reserved.
//

import UIKit

let LANDMARK_SECTION = 0
let STATE_SECTION = 1
let AREA_SECTION = 2
let DATE_SECTION = 3
let IMAGE_SECTION = 4
let URL_SECTION = 5
let SHOWMAP_SECTION = 6
let ADDTO_SECTION = 7


class LandMarkDetailGroupedTableVC: UITableViewController {
    
    var parkList = Parks()
    var mapVC:MapVC!
    
    var parks : [Park] {
        get {
            return self.parkList.parkList!
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
    
  //  var landmark: Landmark!
    
    //var mapVC:MapVC!
    var zoomDeligate:ZoomingProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 8
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //create programmatically not using story board
        
        let landmark = parks[indexPath.row]
        print(landmark)
        
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        }
        
        switch indexPath.section {
        case 0:
            cell!.textLabel?.text = parks[indexPath.indexAtPosition(1)].getParkName()
        case 1:
            cell!.textLabel?.text = parks[indexPath.row].getParkLocation()
        case 2:
            cell!.textLabel?.text = landmark.getArea()
                //landmark.getArea()
        case 3:
            cell!.textLabel?.text = landmark.getDateFormed()
            //cell?.imageView?.image =
        case 4:
            let url = NSURL(string: landmark.getImageLink()) //park is your park object
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let data = NSData(contentsOfURL: url!) //get image from url
                dispatch_async(dispatch_get_main_queue(), {
                    let imageView = UIImageView(frame: CGRectMake(0, 0, cell!.frame.width, cell!.frame.height)) //create image view
                    let image =  UIImage(data: data!) //create image
                    imageView.image = image //add image to imageView
                    cell!.backgroundView = UIView() //set the cell's view to the new imageView
                    cell!.backgroundView!.addSubview(imageView)
                });
            }
        case 5:
            cell!.textLabel?.text = landmark.getLink()
        case 6:
            cell!.textLabel?.text = "Show on Map"
        case 7:
            cell!.textLabel?.text = "Add to Favorites"
       
//            cell!.textLabel?.text = "latitude: \(landmark.coordinate.latitude)\nlongitude: \(landmark.coordinate.longitude)"
        default:
            break
        }
        
        cell?.textLabel?.numberOfLines = 2

        return cell!
    
    }
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var title = ""
//        switch section {
//        case LANDMARK_SECTION:
//            title = "Landmark Name"
//        case STATE_SECTION:
//            title = "Landmark State"
//        case STATE_SECTION:
//            title = "State"
//        case AREA_SECTION:
//            title = "Area"
//        default:
//            break
//        }
//        return title
//    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == IMAGE_SECTION{
            return 300
        }
        else{
           return 44.0
        }
        
    }    /*
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
 
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let landmark = parks[indexPath.row]
            var msg = ""
            switch indexPath.section{
            case SHOWMAP_SECTION:
                msg = "you tapped Show map"
                print(msg)
            case ADDTO_SECTION:
                let alertController = UIAlertController(title: "Added to Favorites", message:
                    "Added to Favroite", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                var array = NSUserDefaults.standardUserDefaults().arrayForKey("favorites") as? [String]
                array?.append(landmark.getParkName())
                
                NSUserDefaults.standardUserDefaults().setObject(array, forKey: "favorites")
                
                print(array)
                
                
                 //the worse way
//                let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
//                
//                (appDel.tabBarController?.viewControllers![0] as! MapVC).zoomOnAnnotation(landmark)
                
                //slightly better 
//                (tabBarController?.viewControllers![0] as! MapVC).zoomOnAnnotation(landmark)
                //2nd best option
               // mapVC.zoomOnAnnotation(landmark)
                
                //best option
                zoomDeligate?.zoomOnAnnotation(landmark)
                
            default:
                break
            }
//            
//            let alert = UIAlertController(title: "tapped a row", message: msg, preferredStyle: .Alert)
//            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//            alert.addAction(OKAction)
//            presentViewController(alert, animated: true, completion: nil)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    }
 
}
