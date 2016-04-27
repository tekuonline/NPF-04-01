//
//  Park.swift
//  NPF-3V2
//
//  Created by Tek Nepal on 4/7/16.
//  Copyright © 2016 Tek Nepal. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import Contacts


class Park:NSObject, MKMapViewDelegate, MKAnnotation
{
   
    private var location:CLLocation? = nil
    private var parkDescription:String=""
    private var parkName:String=""
    private var parkLocation:String=""
    private var dateFormed:String=""
    private var area:String=""
    private var link:String=""
    private var imageLink:String=""
 
    private var imageName:String=""
    private var imageSize:String=""
    private var imageType:String=""
  
    
   
    var title: String?{
        get{
            return parkName
        }
    }
    var subtitle: String?{
        get{
            return parkLocation
        }
    }
  
    @objc var coordinate: CLLocationCoordinate2D {
        get {
            return location!.coordinate
        }
    }
    
    override var description:String{
        return "parkName:\(parkName)\nparkLocation: \(parkLocation)\ndateFormed: \(dateFormed)\narea: \(area)\nlink: \(link)\nlocation: \(location)\nparkDescription: \(parkDescription)\nimageName: \(imageName)\nimageSize: \(imageSize)\nimageType: \(imageType)\nimageLink: \(imageLink)"
    }
    
    
    
    //init
    init(parkName:String,parkLocation:String,dateFormed:String,area:String,link:String,location:CLLocation?,imageLink:String,parkDescription:String,imageName:String,imageSize:String,imageType:String){
        super.init()
        self.setParkName(parkName)
        self.setParkLocation(parkLocation)
        self.setDateFormed(dateFormed)
        self.setArea(area)
        self.setLink(link)
        self.setLocation(location)
        self.setImageLink(imageLink)
        self.setParkDescription(parkDescription)
        self.setImageName(imageName)
        self.setImageSize(imageSize)
        self.setImageType(imageType)
        
    }
    convenience override init(){
        self.init(parkName:"Unknown",parkLocation:"Unknown",dateFormed:"Unknown",area:"Unknown",link:"Unknown",location:nil,imageLink:"Unknown",parkDescription:"Unknown",imageName:"Unknown",imageSize:"Unknown",imageType:"Unknown")
        
    }
    
    
    func getParkName()->String{
        return parkName
    }
    func setParkName(value:String){
        let trim = value.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let num = trim.characters.count
        if(num >= 3 && num <= 75){
            parkName = value
        }else{
            parkName = "TBD"
            print("Bad value of \(value) in setParkName: setting to TBD\n")
        }
    }
    func getParkLocation()->String{
        return parkLocation
    }
    func setParkLocation(value:String){
        let trim = value.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let num = trim.characters.count
        if(num >= 3 && num <= 75){
            parkLocation = value
        }else{
            parkLocation = "TBD"
            print("Bad value of \(value) in setParkLocation: setting to TBD\n")
        }
        
    }
    func getDateFormed()->String{
        return dateFormed
    }
    func setDateFormed(value:String){
        dateFormed = value
    }
    func getArea()->String{
        return area
    }
    func setArea(value:String){
        area = value
    }
    func getLink()->String{
        return link
    }
    func setLink(value:String){
        link = value
    }
    func getLocation()->CLLocation?{
        return location
    }
    func setLocation(value:CLLocation?){
        location = value
    }
    func getImageLink()->String{
        return imageLink
    }
    func setImageLink(value:String){
        imageLink = value
    }
    func getParkDescription()->String{
        return parkDescription
    }
    func setParkDescription(value:String){
        parkDescription = value
    }
    //updated getters and setters (NPF-2)
    func setImageName(value:String){
        imageName = value
    }
    func getImageName()->String{
        return imageName
    }
    func setImageSize(value:String){
        imageSize = value
    }
    func getImageSize()->String{
        return imageSize
    }
    func setImageType(value:String){
        imageType = value
    }
    func getImageType()->String{
        return imageType
    }
 
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(CNPostalAddress): parkName]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    func distance() -> Double{
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        let distance =  (manager.location?.distanceFromLocation(location!))!*0.621371
        return Double(round(100*(distance)/1000)/100)
       //return distance!
        
    }

    
}