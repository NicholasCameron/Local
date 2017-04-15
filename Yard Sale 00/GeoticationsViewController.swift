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
    static let savedItems = "itemsSaved6"
}

var counter = -1;
var counter0 = Int();

class GeoticationsViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var mapKit: MKMapView!
    /////////////////////////////
    var bizName = String()
    var bizDescription = String()
    var bizType = String()
    
    var shouldShowSearchResults = Bool();
    
    var filteredNameArray = [String]()
    var filteredTypeArray = [String]()
    
    @IBOutlet weak var suggestionTable: UITableView!
    
    
    var businessDetailsArray = [BusinessDetail]()
    var businessDetailsFilteredArray = [BusinessDetail]()
    
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    var BusinessLocations : [AddBusiness] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MAPP LOAD LOCATION
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location, span)
        mapKit.setRegion(region, animated: true)
        
        
        loadAllGeotifications()
        
        mapKit.delegate = self
        ////////TABLE AND SEARCH//////////////
        
        
        searchBar.backgroundImage = UIImage()        
        
        searchBar.delegate = self
        //TABLE VIEW
        
        suggestionTable.dataSource = self
        suggestionTable.delegate = self
        
        
    
        
        
    }
    
    
    
   
    

    
    func loadAllGeotifications() {
      
        let users =  DataManager.getUsers();

        
        for u in users{
            
            add(business: u)

            let details = BusinessDetail(businessName:u.businessName,businessDescription:u.businessDescription,businessType:u.type)
            
            businessDetailsArray.append(details);
        

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
        
        
        if let indexInArray = BusinessLocations.index(of: geotification) {
            BusinessLocations.remove(at: indexInArray)
        }
        mapKit.removeAnnotation(geotification)
        updateGeotificationsCount()
    }
    
    func updateGeotificationsCount() {
      //  title = "Business Locations (\(BusinessLocations.count))"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGeotification" {
            let navigationController = segue.destination as! UINavigationController
            let vc = navigationController.viewControllers.first as! AddGeotification
           // vc.delegate = self
            
        }
    }//end of prepare to transition
    
    
    
    
    func filterContentForSearchText(searchController: String) {
        let searchString = searchController
        var businessNameArray = [String]();
        var businessTypeArray = [String]();
        var businessDescriptionArray = [String]();
        
        for name in businessDetailsArray{
            businessNameArray.append(name.businessName)
            businessTypeArray.append(name.businessType)
            businessDescriptionArray.append(name.businessDescription)
            
        }
        
        // Filter the data array and get only those countries that match the search text.
        filteredNameArray = businessNameArray.filter({ (names) -> Bool in
            let namesText: NSString = (names) as NSString;
            
            return (namesText.range(of: searchString, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        filteredTypeArray = businessTypeArray.filter({ (type) -> Bool in
            let typeText: NSString = (type) as NSString;
            
            return (typeText.range(of: searchString, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        for bizDetails in businessDetailsArray{
            for names in filteredNameArray{
                for types in filteredTypeArray{
                    for description in businessDescriptionArray{
                        
                        if(bizDetails.businessName == names || bizDetails.businessType == types){
                            
                            businessDetailsFilteredArray = [BusinessDetail(businessName: names,businessDescription: types,businessType: description)];
                            
                        }
                    }
                }
            }
        }
        
        shouldShowSearchResults = true;
        // Reload the tableview.
        
        
           suggestionTable.reloadData();
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.suggestionTable.alpha = 1.0
            
        })
        
        
        // tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        // tableView.reloadData()
        searchBar.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {
            self.suggestionTable.alpha = 0
            
        })
        searchBar.text = "";
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            //   tableView.reloadData()
        }
        
        searchBar.resignFirstResponder()
        
    }
    
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){ // called when text changes (including clear)
        let searchString = searchText
        UIView.animate(withDuration: 0.5, animations: {
            self.suggestionTable.alpha = 1.0
            
        })
        
        if(searchBar.text != ""){
            // Filter the data array and get only those countries that match the search text.
            filterContentForSearchText(searchController: searchString)
            
            shouldShowSearchResults = true;
        }else{
            shouldShowSearchResults = false;
            
        }
        // Reload the tableview.
        suggestionTable.reloadData()
       // suggestionTable.beginUpdates()
    }
    
    
    
    
    
    public func updateSearchResults(for searchController: UISearchController)
    {
        
    }
    
    
    
    //////////////////  TABLE VIEW   ///////////////////////
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if shouldShowSearchResults {
            return businessDetailsFilteredArray.count
        }
        else {
            
            return businessDetailsArray.count
        }
    }
    
    
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = suggestionTable.dequeueReusableCell(withIdentifier: "mapCell")! as! MapTableViewCell
        cell.sizeToFit();
        
        

        
        if shouldShowSearchResults {
            cell.businessTitle?.text = businessDetailsFilteredArray[indexPath.row].businessName
            cell.lblDistance.text = "19 KM"

        }else {
            
        
            cell.businessTitle?.text = businessDetailsArray[indexPath.row].businessName
         //   cell.detailTextLabel?.text = businessDetailsArray[indexPath.row].businessDescription
           cell.lblDistance.text = "19 KM"
        }
        print(indexPath.row)

        cell.backgroundColor = .clear
        
        return cell;
        
    }
    
    @available(iOS 2.0, *)
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1;
    }
    
    

    
    
    
}//END CLASS




//// This is initializing the protocol so that self can be assigned to the protocol.
//extension GeoticationsViewController: AddGeotificationDelegate {
//    
//    func addGeotificationViewController(controller: AddGeotification, didAddCoordinate coordinate:
//        
//        CLLocationCoordinate2D, businessName: String, businessDescription: String,pinColor:String) {
//        controller.dismiss(animated: true, completion: nil)
//        let geotification = AddBusiness(coordinate: coordinate, businessName: businessName, businessDescription: businessDescription,pinColor: pinColor,type:businessTypeOfficial)
//        add(business: geotification)
//    }
//}

//___________________________________________________________________________________________
//MAPKIT CODE }
// MARK: - MapView Delegate


extension GeoticationsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myGeotifications"
        if annotation is AddBusiness {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            
            for b in BusinessLocations{
                
                
                if b.coordinate.latitude == annotation.coordinate.latitude && b.coordinate.longitude == annotation.coordinate.longitude{
                 
                    
                    annotationView?.pinTintColor = UIColorFromRGB(color: b.pinColor)

                    
                }
                
            }
            
            
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                //set to something
                
                for b in BusinessLocations{
                    
                    
                    if b.coordinate.latitude == annotation.coordinate.latitude && b.coordinate.longitude == annotation.coordinate.longitude{
                        
                        
                        annotationView?.pinTintColor = UIColorFromRGB(color: b.pinColor)
                        
                        
                    }
                    
                }
                annotationView?.canShowCallout = true

                let removeButton = UIButton(type: .custom)
                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                removeButton.setImage(UIImage(named: "profileIcon")!, for: .normal)
                annotationView?.leftCalloutAccessoryView = removeButton as UIView
               
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    

    
    func UIColorFromRGB(color: String) -> UIColor {
        
        
        if(color == "red"){
            return UIColor.red
        }else if(color == "green"){
            return UIColor.green
        }else if (color == "purple"){
            return UIColor.purple
        }else if(color == "black"){
            return UIColor.black
        }else if(color == "orange"){
            return UIColor.orange
        }else if(color == "yellow"){
            return UIColor.yellow
        }else if(color == "brown"){
            return UIColor.brown
        }else if(color == "pink"){
            return UIColor.magenta
        }else if(color == "grey"){
            return UIColor.gray

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
        let business = view.annotation as! AddBusiness
        
        
        ProfilePage.profileName = business.businessName
        ProfilePage.profileType = business.businessDescription
   
        let color = business.pinColor
        if(color == "red"){

            ProfilePage.bgColor = UIColor(
                red: CGFloat((242)) / 255.0,
                green: CGFloat((181)) / 255.0,
                blue: CGFloat(180) / 255.0,
                alpha: CGFloat(1.0)
            )
        
        
        }else if(color == "green"){

            ProfilePage.bgColor
= UIColor(
                red: CGFloat((195)) / 255.0,
                green: CGFloat((250)) / 255.0,
                blue: CGFloat(182) / 255.0,
                alpha: CGFloat(1.0)
            )
        
        }else if (color == "purple"){
            
            ProfilePage.bgColor = UIColor(
                red: CGFloat((187)) / 255.0,
                green: CGFloat((181)) / 255.0,
                blue: CGFloat(250) / 255.0,
                alpha: CGFloat(1.0)
            )
        
        
        }else if(color == "black"){

            ProfilePage.bgColor = UIColor(
                red: CGFloat((55)) / 255.0,
                green: CGFloat((56)) / 255.0,
                blue: CGFloat(54) / 255.0,
                alpha: CGFloat(1.0)
            )
        
        }else if(color == "orange"){

        
            ProfilePage.bgColor = UIColor(
                red: CGFloat((248)) / 255.0,
                green: CGFloat((218)) / 255.0,
                blue: CGFloat(182) / 255.0,
                alpha: CGFloat(1.0)
            )
        
        
        }else if(color == "yellow"){

            ProfilePage.bgColor = UIColor(
                red: CGFloat((253)) / 255.0,
                green: CGFloat((247)) / 255.0,
                blue: CGFloat(183) / 255.0,
                alpha: CGFloat(1.0)
            )
        
        }else if(color == "brown"){
            
            ProfilePage.bgColor = UIColor(
                red: CGFloat((201)) / 255.0,
                green: CGFloat((173)) / 255.0,
                blue: CGFloat(140) / 255.0,
                alpha: CGFloat(1.0)
            )
        
        }else if(color == "pink"){

        
            ProfilePage.bgColor = UIColor(
                red: CGFloat((239)) / 255.0,
                green: CGFloat((170)) / 255.0,
                blue: CGFloat(251) / 255.0,
                alpha: CGFloat(1.0)
            )
        
        
        }else if(color == "grey"){

            ProfilePage.bgColor = UIColor(
                red: CGFloat((224)) / 255.0,
                green: CGFloat((224)) / 255.0,
                blue: CGFloat(224) / 255.0,
                alpha: CGFloat(1.0)
            )
            
            
        }else{
        ProfilePage.bgColor = UIColor(
                red: CGFloat((235)) / 255.0,
                green: CGFloat((192)) / 255.0,
                blue: CGFloat(73) / 255.0,
                alpha: CGFloat(1.0)
            )
        }

        
        
        //  ProfilePage.profileHours = business.
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    
        

    
    }
    
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
       print("click")
    
    }
    
    
    
    
}








