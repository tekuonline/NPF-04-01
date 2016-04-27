//
//  MapVC.swift
//  NPF-4
//
//  Created by Tek Nepal on 4/20/16.
//  Copyright © 2016 Tek Nepal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    var location:CLLocation?
    var coords:CLLocationCoordinate2D!
    
    @IBOutlet weak var uiIndicatorView:UIActivityIndicatorView!
    
    @IBAction func currLocation(){
        let mkCoordinateRegion = MKCoordinateRegionMakeWithDistance(location!.coordinate, 20000, 20000)
        mapView.setRegion(mkCoordinateRegion, animated: true)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    var parkList = Parks()
    var parks : [Park] {
        get {
            return self.parkList.parkList!
        }
        set(val) {
            self.parkList.parkList = val
        }
    }
    
    @IBAction func MapType(sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapType.Standard
            break;
        case 1:
            self.mapView.mapType = MKMapType.Hybrid
            break;
        case 2:
            self.mapView.mapType = MKMapType.Satellite
            break;
        case 3:
            self.mapView.mapType = MKMapType.HybridFlyover
            break;
        default:
            break;
        }
        
    }
    
    
    func zoomOnAnnotation(annotation:MKAnnotation){
        tabBarController?.selectedViewController = self
        
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
        mapView.setRegion(region, animated: true)
        mapView.selectAnnotation(annotation, animated: true)
    }
    //this method is called once for every annotation created
    //if we dont a view the default is used
    func mapView(mv: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var view:MKAnnotationView
        let identifier = "Pin"
        
        if annotation is MKUserLocation{
            return nil
        }
        if annotation !== mv.userLocation{
            //look for an exesting view for reuse
            if let dequeuedView = mv.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView{
                view = dequeuedView
            }
            else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                
                let leftButton = UIButton(type: .InfoLight)
                let rightButton = UIButton(type: .DetailDisclosure)
                leftButton.tag = 0
                rightButton.tag = 1
                view.leftCalloutAccessoryView = leftButton
                view.rightCalloutAccessoryView  = rightButton
                
            }
            return view
        }
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled(){
            if locationManager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)){
                locationManager.requestAlwaysAuthorization()
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            startUpdating()
        }
        //add parks to map view
        for park:Park in parks {
            mapView.addAnnotation(park)
        }


        // Do any additional setup after loading the view.
    }
    
    func startUpdating(){
        uiIndicatorView.startAnimating()
        locationManager.startUpdatingLocation()
    }
    func stopUpdating(){
        uiIndicatorView.stopAnimating()
        uiIndicatorView.hidesWhenStopped = true;
        locationManager.stopUpdatingLocation()
        //let mkCoordinateRegion = MKCoordinateRegionMakeWithDistance(location!.coordinate, 200, 200)
        //mapView.setRegion(mkCoordinateRegion, animated: true)
    }
    @IBAction func refresh(){
//        let mkCoordinateRegion = MKCoordinateRegionMakeWithDistance(location!.coordinate, 2000000, 2000000)
//        mapView.setRegion(mkCoordinateRegion, animated: true)
        let mKCoordinateRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(39.5, -98.35), 450000, 4500000)
        mapView?.setRegion(mKCoordinateRegion, animated: true)
        
        //startUpdating()
    }

    
    
    func mapView(mv: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let parkAnnotation = view.annotation as! Park
        switch control.tag {
        case 0: //left button
            if let url = NSURL(string: parkAnnotation.getLink()){
                UIApplication.sharedApplication().openURL(url)
            }
        case 1:
//            let geocoder = CLGeocoder()
//            let sel = parkAnnotation.getLocation()
////            let latitude = sel?.coordinate.latitude
////            let longitude = sel?.coordinate.longitude
////            var address : (String) = ""
//            
//               // let geocoder = CLGeocoder()
//                //let addressString = "\(address.text) \(city.text) \(state.text) \(zip.text)"
////                geocoder.reverseGeocodeLocation(sel!, completionHandler: {(placemarks:[CLPlacemark]?, error:NSError?)->Void in
////               // geocoder.geocodeAddressString(addressString, completionHandler: {(placemarks:[CLPlacemark]?, error:NSError?)->Void in
////                    
////                    if let placemark = placemarks?[0]{
////                        let local = placemark.locality;
////                        let postalCode = placemark.postalCode
////                        let administrativeArea = placemark.administrativeArea
////                        let country = placemark.country
////                        let dict = placemark.addressDictionary
////                        
////                        
////                        let place = MKPlacemark(coordinate: coords, addressDictionary: Dictionary)
////                        let mapItem = MKMapItem(placemark: place)
////                        let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
////                        mapItem.openInMapsWithLaunchOptions(options)
////                        
//////                        
//////                         print(local)
//////                         print(postalCode)
//////                         print(administrativeArea)
//////                         print(country)
////                       //  print(dict)
////                        
////                        
////                        }
////                    
////                    
////                })
//            let location = CLLocation(latitude: sel!.coordinate.latitude, longitude: sel!.coordinate.longitude)
//            geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
//                
//                // Place details
//                var placeMark: CLPlacemark!
//                placeMark = placemarks?[0]
//                
//                // Address dictionary
//                print(placeMark.addressDictionary)
//                
//                // Location name
//                if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
//                    print(locationName)
//                }
//                
//                // street address
//                if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
//                    print(street)
//                }
//                
//                // City
//                if let city = placeMark.addressDictionary!["City"] as? NSString {
//                    print(city)
//                }
//                
//                // Zip code
//                if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
//                    print(zip)
//                }
//                
//                // Country
//                if let country = placeMark.addressDictionary!["Country"] as? NSString {
//                    print(country)
//                }
//            })
//           
//            
//            
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            parkAnnotation.mapItem().openInMapsWithLaunchOptions(launchOptions)
            
                default:
                break
            }
        }
    
    
    
    //Determines if location use is authorized
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        switch status{
        case .AuthorizedAlways:
            //location is authorized! update user location!
            locationManager.startUpdatingLocation()
        case .NotDetermined:
            locationManager.requestAlwaysAuthorization()
        case .AuthorizedWhenInUse, .Restricted, .Denied:
            let alertController = UIAlertController(title: "Background Location Access Disabled", message: "We need to access your location. Please open the app settings and set location access to always", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            let openAction = UIAlertAction(title: "open Settings", style: .Default, handler: {(action) in if let url = NSURL(string: UIApplicationOpenSettingsURLString){
                UIApplication.sharedApplication().openURL(url)
                }})
            alertController.addAction(openAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        let errorAlert = UIAlertController(title: "Error", message: "Failed to get your location", preferredStyle: .Alert)
        let OK = UIAlertAction(title: "OK", style: .Default, handler: nil)
        errorAlert.addAction(OK)
        self.presentViewController(errorAlert, animated: true, completion: nil)
    }
    
    //Sets location to what is was last and stops updating the location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation: AnyObject = locations[0]
        //let mKCoordinateRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 20000, 20000)
        //mapView?.setRegion(mKCoordinateRegion, animated: true)
        
        //add Anotation
        let point = MKPointAnnotation()
        point.coordinate = newLocation.coordinate
       // mapView?.addAnnotation(point)
        
        if location == nil {
            location = newLocation as? CLLocation
            locationManager.stopUpdatingLocation()
        }
        stopUpdating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
