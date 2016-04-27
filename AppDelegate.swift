//
//  AppDelegate.swift
//  NPF-04-01
//
//  Created by Tek Nepal on 4/24/16.
//  Copyright © 2016 Tek Nepal. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var tabBarController:UITabBarController?
    var parks:[Park] = []

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        loadData()
       
        tabBarController = self.window?.rootViewController as? UITabBarController
        let mapVC = tabBarController!.viewControllers![0] as! MapVC
        mapVC.parks = parks
        let navVC = tabBarController!.viewControllers![1] as! UINavigationController
        let tableVC = navVC.viewControllers[0] as! ParkTableVC
        tableVC.parks = parks
        tableVC.mapVC = mapVC
        //tableVC.parkList = parks!
        //tabBarController = self.window?.rootViewController as? UITabBarController
        
        //let mapVC = tabBarController!.viewControllers![0] as! MapVC
        
        //  mapVC.parks = parks
        
        
        //        let navVC = tabBarController!.viewControllers![1] as! UINavigationController
        //        let tableVC = navVC.viewControllers[0] as! FirstViewController
        //
        //
        //        tableVC.parks = parks
        //
        //        tableVC.mapVC = mapVC
        // let tableVC = navVC.viewControllers[0] as! LandmarksTableVC
        
        // tableVC.landmarks = landmarks
        
        // tableVC.mapVC = mapVC
        return true
    }
    
    func loadData(){
        if let path = NSBundle.mainBundle().pathForResource("data", ofType: "plist"){
            let tempDict = NSDictionary(contentsOfFile: path)
            let tempArray = (tempDict!.valueForKey("parks")as! NSArray)as Array
            
            for dict in tempArray{
                let parkName = dict["parkName"]!as!String
                let area = dict["area"]!as!String
                let dateFormed = dict["dateFormed"]!as!String
                let description = dict["parkName"]!as!String
                let imageLink = dict["imageLink"]!as!String
                let imageName = dict["imageName"]!as!String
                let imageSize = dict["imageSize"]!as!String
                let imageType = dict["imageType"]!as!String
                let link = dict["link"]!as!String
                let parkLocation = dict["parkLocation"]!as!String
                let latitude = (dict["latitude"]!as! NSString).doubleValue
                let longitude = (dict["longitude"]!as! NSString).doubleValue
                let location = CLLocation(latitude:latitude, longitude:longitude)
                
                //                let p = Park(parkName: parkName, parkLocation: parkLocation, dateFormed: dateFormed, area: area, link: link, location: location, imageLink: imageLink, parkDescription: description, imageName: imageName, imageSize: imageSize, imageType: imageType, latitude:latitude, longitude: longitude)
                let q = Park(parkName: parkName, parkLocation: parkLocation, dateFormed: dateFormed, area: area, link: link, location: location, imageLink: imageLink, parkDescription: description, imageName: imageName, imageSize: imageSize, imageType: imageType)
                
                parks.append(q);
                
                //                for q in parks{
                //                   // print("Park: \(q)")
                //                }
                
                
            }
            
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

