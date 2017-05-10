//
//  AddGeotification.swift
//  MapKitRecreation
//
//  Created by Nicholas Cameron on 2016-10-27.
//  Copyright © 2016 IBM. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI

protocol AddGeotificationDelegate: class {
    
    func addGeotificationViewController(controller: AddGeotification, didAddCoordinate coordinate: CLLocationCoordinate2D,businessName: String, businessDescription: String,pinColor: String)
}

class AddGeotification: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,MKMapViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate {
  
    var iszoomed = Bool()
      
    var matchingItems:[MKMapItem] = []
    var selectedLocation = CLLocationCoordinate2D();
    var zoomLatitude = Double()
    var zoomLongitude = Double()
    var StreetFilter = String()
    
    @IBOutlet weak var addPin: UIImageView!
    @IBOutlet weak var btnAddressFiltered: UIButton!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var addressSearchBar: UISearchBar!
    @IBOutlet weak var pin: UIImageView!
    
    //This is description
    var businessType = String();
    //This is name.
   // @IBOutlet weak var raduisTextField: UITextField!
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var typePicker: UIPickerView!
    
    @IBOutlet weak var lblLocation: UILabel!
    //PICKERVIEW DATA
    let pickerData = ["CoffeeShop","Resturant","GiftShop","Golf","Food","Entertainment","Shop","Fun","Exercise", "Trail"]
    let ColorValues = ["brown","purple","white","green","red","black","pink","orange","grey","green"]
    var pinColorValue = String();
    //ICON IMAGE
    
    @IBOutlet weak var iconImage: UIImageView!
    
    
    
    //ADDGEOTIFICATIONDELEGATE
   weak var delegate: AddGeotificationDelegate?

//location manager
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled(){
            
          //  locationManager.requestAlwaysAuthorization()
            locationManager.delegate = self
            locationManager.requestLocation()
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mapKit.showsUserLocation = true
        }

        
        //zoom in on an initial location
        if BusinessProperties.properties.usersLocation.longitude == 0{
            
            
            BusinessProperties.properties.usersLocation.latitude = 40.759211000000001
            BusinessProperties.properties.usersLocation.longitude = -73.984638000000003
        }
       

        let span = MKCoordinateSpanMake(BusinessProperties.properties.latDelta, BusinessProperties.properties.lonDelta)
        let region = MKCoordinateRegionMake(BusinessProperties.properties.usersLocation, span)
        mapKit.setRegion(region, animated: true)

        
        btnAddressFiltered.isHidden = true
        mapKit.delegate = self;
        
        
        
      
        
       
        
        
        lblLocation.text = "Place pin on location or search"
        typePicker.dataSource = self
        
        addressSearchBar.delegate = self
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {

      //  raduisTextField.resignFirstResponder()
        
        return true
    }

    
    ///PICKER VIEW PROTOCOLS.
    
    @available(iOS 2.0, *)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        businessType = pickerData[row]
        return pickerData[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pinColorValue = ColorValues[row]
        
        switch pinColorValue{
          //  let ColorValues = ["brown","purple","white","green","red","black","pink","blue","grey","green"]

        case "brown":
            pin.image = UIImage(named:"brownPin")
            addPin.image = UIImage(named:"brownPin")

        case "green":
            pin.image = UIImage(named:"greenPin")
            addPin.image = UIImage(named:"greenPin")

        case "pink":
            pin.image = UIImage(named:"pinkPin")
            addPin.image = UIImage(named:"pinkPin")


        case "grey":
            pin.image = UIImage(named:"greyPin")
            addPin.image =  UIImage(named:"greyPin")


        case "purple":
            pin.image = UIImage(named:"purplePin")
            addPin.image = UIImage(named:"purplePin")

        case "black":
            pin.image = UIImage(named:"blackPin")
            addPin.image = UIImage(named:"blackPin")

        case "white":
            pin.image = UIImage(named:"whitePin")
            addPin.image = UIImage(named:"whitePin")

        case "yellow":
            pin.image = UIImage(named:"yellowPin")
            addPin.image = UIImage(named:"yellowPin")

        case "orange":
            pin.image = UIImage(named:"orangePin")
            addPin.image = UIImage(named:"orangePin")

            
        default: pin.image = UIImage(named:"AddPin")
        addPin.image = UIImage(named:"AddPin")

        }
        
       BusinessProperties.properties.pinColor = pinColorValue

        
        
        
        
        
        
    }
    
    
    
    
    //END OF PICKER VIEW
    
     func mapView(_ mapView: MKMapView,regionDidChangeAnimated animated: Bool){
            let mapLatitude = mapKit.centerCoordinate.latitude
            let mapLongitude = mapKit.centerCoordinate.longitude
            BusinessProperties.properties.center = "Latitude: \(mapLatitude) Longitude: \(mapLongitude)"
        lblLocation.text = (reverseGeocoding(latitude: mapLatitude, longitude: mapLongitude))

    
    ///SET THE STREET AS WHAT IS CHOSEN
        BusinessProperties.properties.businessStreet = lblLocation.text!;
    
    }
    

    @IBAction func AddLocation(_ sender: AnyObject) {
  
     BusinessProperties.properties.latitude = String(mapKit.centerCoordinate.latitude)
        BusinessProperties.properties.longitude = String(mapKit.centerCoordinate.longitude)
         BusinessProperties.properties.businessDescription = businessType
         BusinessProperties.properties.pinColor = pinColorValue
        BusinessProperties.properties.businessTypeOfficial = BusinessProperties.properties.businessDescription;
       
        ///////////////////////////////////////////////////////////

      //  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       // let nextViewController = storyBoard.instantiateViewController(withIdentifier: "businessInformation") as! BusinessInformationViewController
        
        //self.present(nextViewController, animated:true, completion:nil)
    //  self.dismissViewController(AddLocation)
       // self.dismiss(animated: true, completion: nil)
     //   performSegue(withIdentifier: "businessInformation", sender: nil)
   
      //  self.removeFromParentViewController()
    }
    
    
    
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)

    }
    
    
    
    ///////////////SEARCH BAR***********
    @available(iOS 2.0, *)
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool // return NO to not become first responder
    {
        return true;
    }
    @available(iOS 2.0, *)
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing
        
    {
        //search table
        addressSearchBar.text = ""
        
        btnAddressFiltered.isHidden = false;
        
        
    }
    
    
    @available(iOS 2.0, *)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    {
        let request = MKLocalSearchRequest()
        var cityToSearch = MKCoordinateRegion();
        cityToSearch.center = BusinessProperties.properties.usersLocation;
        request.naturalLanguageQuery = searchBar.text
        request.region = cityToSearch;
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard response != nil else {
                return
            }
            self.matchingItems = (response?.mapItems)!
            
            for match in self.matchingItems{
                
                 self.StreetFilter = self.parseAddress(selectedItem: match.placemark)
                
                self.btnAddressFiltered.setTitle(self.StreetFilter, for: .normal)
                self.zoomLatitude = (selectedItem: match.placemark.coordinate.latitude) as! Double
                 self.zoomLongitude = (selectedItem: match.placemark.coordinate.longitude) as! Double

            }

        }
        
    }
    
    @IBAction func btnZoomLocationClicked(_ sender: Any) {
  
    
        
        
        let mapLatitude = zoomLatitude
        let mapLongitude = zoomLongitude
    
        BusinessProperties.properties.center = "Latitude: \(mapLatitude) Longitude: \(mapLongitude)"
        lblLocation.text = (reverseGeocoding(latitude: mapLatitude, longitude: mapLongitude))
        
     //   print((reverseGeocoding(latitude: mapLatitude, longitude: mapLongitude)))
        ///SET THE STREET AS WHAT IS CHOSEN
        BusinessProperties.properties.businessStreet = lblLocation.text!;
        
        BusinessProperties.properties.center = "Latitude: \(mapLatitude) Longitude: \(mapLongitude)"
        lblLocation.text = (reverseGeocoding(latitude: mapLatitude, longitude: mapLongitude))
      //  print((reverseGeocoding(latitude: mapLatitude, longitude: mapLongitude)))

        
        ///SET THE STREET AS WHAT IS CHOSEN
        BusinessProperties.properties.businessStreet = lblLocation.text!;

        
        
        let latitude:CLLocationDegrees = zoomLatitude//insert latitutde
        
        let longitude:CLLocationDegrees = zoomLongitude//insert longitude
        
        let latDelta:CLLocationDegrees = 0.01
        
        let lonDelta:CLLocationDegrees = 0.01
        
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region = MKCoordinateRegionMake(location, span)
        
        mapKit.setRegion(region, animated: false)
        
    }
    
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees)->String {
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            
            
            if error != nil {
                print("Error")
                return
            }
            else if (placemarks?.count)! > 0 {
                let pm = placemarks![0]
                let address = ABCreateStringWithAddressDictionary(pm.addressDictionary!, false)
                print("\n\(address)")
                locations = address;
                
                self.lblLocation.text = address
                
                
            }
        })
        return locations
    }
    
    
    
    @available(iOS 2.0, *)
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) // called when cancel button pressed
    {
        
        searchBar.resignFirstResponder();
        searchBar.text = "";
    }
    

    
    //LOCATION MANAGER
     private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            print("location:: (location)")

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        BusinessProperties.properties.usersLocation = locations[0].coordinate
        //MAPP LOAD LOCATION
        if iszoomed == false{
            let span = MKCoordinateSpanMake(BusinessProperties.properties.latDelta, BusinessProperties.properties.lonDelta)
            let region = MKCoordinateRegionMake(BusinessProperties.properties.usersLocation, span)
            mapKit.setRegion(region, animated: true)

        }
        iszoomed = true
    }
    

    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location manager failing")
    }
    
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    ///////////////End Table View&&&&&&&&&&&&&&&&&&
    
   
    
    deinit {
        
        print("end of this view")
    }
 
    
}
