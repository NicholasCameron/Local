//
//  LocoHome.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2016-12-05.
//  Copyright © 2016 Nick J Cameron. All rights reserved.
//

import UIKit
import Foundation


//var Businesses = [String:AnyObject]()


//struct BusinessDetail{
//    let businessName: String
//    let businessDescription: String
//    let businessType: String
//}



class LocoHome: UIViewController, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var suggestionTable: UITableView!
    
    
    var bizName = String()
    var bizDescription = String()
    var bizType = String()
  
    var shouldShowSearchResults = Bool();
    
    var filteredNameArray : [String]?
    var filteredTypeArray : [String]?

    
    
    var businessDetailsArray = [BusinessDetail]()
    var businessDetailsFilteredArray = [BusinessDetail]()

    
    //////////SEARCH BAR
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        suggestionTable.dataSource = self;
        suggestionTable.delegate = self;
        
        
     
      // configureSearchController()
      //  configureCustomSearchController()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //////////////////  SEARCH BAR   ///////////////////////
    
    
    
    
    /*
     Filtering Function
     
     - parameter searchController: String to Filter by type and name.
     
     - returns: Array of filtered businesses.
     */
    func filterContentForSearchText(searchController: String) {
        let searchString = searchController
        var businessNameArray = [String]();
        var businessTypeArray = [String]();
        var businessDescriptionArray = [String]();

        for name in businessDetailsArray{
            businessNameArray.append(name.businessName)
            businessTypeArray.append(name.businessDescription)
          //  businessDescriptionArray.append(name.businessDescription)

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
            for names in filteredNameArray!{
                for types in filteredTypeArray!{
//                    for description in businessDescriptionArray{
//
//                    if(bizDetails.businessName == names || bizDetails.businessDescription == types){
//                        
//                        businessDetailsFilteredArray = [BusinessDetail(businessName: names,businessDescription: types,businessType: description,location: AppController.shared.businessCoordinates)];
//
//                        }
//                    }
                }
            }
        }
        
        shouldShowSearchResults = true;
        // Reload the tableview.
        
        
        //   suggestionTable.reload();
        
    }

    
       func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
       // tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
       // tableView.reloadData()
        searchBar.resignFirstResponder()
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
        
        
        if(searchBar.text != ""){
        // Filter the data array and get only those countries that match the search text.
       filterContentForSearchText(searchController: searchString)
    
        shouldShowSearchResults = true;
        }else{
            shouldShowSearchResults = false;

        }
        // Reload the tableview.
        suggestionTable.reloadData()
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
        let cell = suggestionTable.dequeueReusableCell(withIdentifier: "suggestions")! as UITableViewCell
        cell.sizeToFit();
        if shouldShowSearchResults {
            cell.textLabel?.text = businessDetailsFilteredArray[indexPath.row].businessName
            
    }else {
            
        cell.textLabel?.text = businessDetailsArray[indexPath.row].businessName
        cell.detailTextLabel?.text = businessDetailsArray[indexPath.row].businessDescription
        
        }
        return cell;
        
    }
    
    @available(iOS 2.0, *)
     func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
     {
        return 1;
    }

}
