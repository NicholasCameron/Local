//
//  GeoticationsViewController.swift
//  MapKitRecreation
//
//  Created by Nicholas Cameron on 2016-10-27.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit
import MapKit;
import CoreLocation





struct PreferencesKeys {
    static let savedItems = "itemsSaved"
}

var counter = -1;
var counter0 = Int();

class GeoticationsViewController: UIViewController {
    
    @IBOutlet weak var mapKit: MKMapView!
    
    
    var BusinessLocations : [AddBusiness] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MAPP LOAD LOCATION
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location, span)
        mapKit.setRegion(region, animated: false)
        
        
        loadAllGeotifications()
        
    }
    
    func loadAllGeotifications() {
        BusinessLocations = []
        guard let savedItems = UserDefaults.standard.array(forKey: PreferencesKeys.savedItems) else { return }
        for savedItem in savedItems {
            guard let geotification = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? AddBusiness else { continue }
            
            add(business: geotification)
        }
    }
    
    
    func add(business: AddBusiness) {
        BusinessLocations.append(business)
        
        mapKit.addAnnotation(business)
        
        
        // addRadiusOverlay(forGeotification: business)
        updateGeotificationsCount()

    }
    
    func remove(geotification: AddBusiness) {
       
        ///SWITCH TO GO TO 
        
        
        counter -= 1;
        if let indexInArray = BusinessLocations.index(of: geotification) {
            BusinessLocations.remove(at: indexInArray)
        }
        mapKit.removeAnnotation(geotification)
        updateGeotificationsCount()
    }
    
    func updateGeotificationsCount() {
      //  title = "Business Locations (\(BusinessLocations.count))"
    }
    
    func saveAllGeotifications() {
        var items: [Data] = []
        for businesses in BusinessLocations {
            let item = NSKeyedArchiver.archivedData(withRootObject: businesses)
            items.append(item)
        }
        UserDefaults.standard.set(items, forKey: PreferencesKeys.savedItems)
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGeotification" {
            let navigationController = segue.destination as! UINavigationController
            let vc = navigationController.viewControllers.first as! AddGeotification
            vc.delegate = self
            
        }
    }//end of prepare to transition
}//END CLASS




// This is initializing the protocol so that self can be assigned to the protocol.
extension GeoticationsViewController: AddGeotificationDelegate {
    
    func addGeotificationViewController(controller: AddGeotification, didAddCoordinate coordinate:
        
        CLLocationCoordinate2D, businessName: String, businessDescription: String,pinColor:String) {
        controller.dismiss(animated: true, completion: nil)
        let geotification = AddBusiness(coordinate: coordinate, businessName: businessName, businessDescription: businessDescription,pinColor: pinColor)
        add(business: geotification)
        saveAllGeotifications()
    }
}

//___________________________________________________________________________________________
//MAPKIT CODE }
// MARK: - MapView Delegate


extension GeoticationsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myGeotifications"
        if annotation is AddBusiness {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            counter += 1;
            //Figure out how to add different color pins into database
            //for biz in BusinessLocations {
            //   annotationView?.pinTintColor = UIColorFromRGB(color: biz.pinColor)
            
            //    }
            annotationView?.pinTintColor = UIColorFromRGB(color:BusinessLocations[counter].pinColor);
            
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                //set to something
                annotationView?.canShowCallout = true
                
                
                
                //Figure out how to add different color pins into database
                
                
                /// SO THIS IS WHATS HAPPENING
                //WHEN IT LOADS IT KEEPS ON ASSIGNING ANNOTIATION VIEW THE VALUE
                //BUT ONLY RETURNS THE LAST ONE.
                
                // for biz in BusinessLocations {
                //     annotationView?.pinTintColor = UIColorFromRGB(color: biz.pinColor)
                // }
                annotationView?.pinTintColor = UIColorFromRGB(color:BusinessLocations[counter].pinColor);
                
                let removeButton = UIButton(type: .custom)
                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                removeButton.setImage(UIImage(named: "home")!, for: .normal)
                annotationView?.leftCalloutAccessoryView = removeButton
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    
    //        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    //            if overlay is MKCircle {
    //                let circleRenderer = MKCircleRenderer(overlay: overlay)
    //                circleRenderer.lineWidth = 1.0
    //                circleRenderer.strokeColor = .purple
    //                circleRenderer.fillColor = UIColor.purple.withAlphaComponent(0.4)
    //                return circleRenderer
    //            }
    //            return MKOverlayRenderer(overlay: overlay)
    //        }
    //
    
    func UIColorFromRGB(color: String) -> UIColor {
        
        
        if(color == "red"){
            return UIColor.red
        }else if(color == "green"){
            return UIColor.green
        }else if (color == "purple"){
            return UIColor.purple
        }else if(color == "white"){
            return UIColor.white
        }else if(color == "black"){
            return UIColor.black
        }else if(color == "orange"){
            return UIColor.orange
        }else if(color == "yellow"){
            return UIColor.yellow
        }else if(color == "brown"){
            return UIColor.brown
        }else{
            return UIColor(
                red: CGFloat((235)) / 255.0,
                green: CGFloat((192)) / 255.0,
                blue: CGFloat(73) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Delete geotification
        let geotification = view.annotation as! AddBusiness
        remove(geotification: geotification)
        saveAllGeotifications()
    }
    
}








