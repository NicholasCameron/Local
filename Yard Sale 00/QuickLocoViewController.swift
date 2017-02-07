//
//  QuickLocoViewController.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-01-24.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit
import Foundation


var Businesses = [String:AnyObject]()


struct BusinessDetail{
    let businessName: String
    let businessDescription: String
    let businessType: String
}




class QuickLocoViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var suggestionTable: UITableView!
    
    
    var bizName = String()
    var bizDescription = String()
    var bizType = String()
    
    var shouldShowSearchResults = Bool();
    
    var filteredNameArray = [String]()
    var filteredTypeArray = [String]()
    
    
    
    var businessDetailsArray = [BusinessDetail]()
    var businessDetailsFilteredArray = [BusinessDetail]()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        suggestionTable.ViewBackground(image: "tableviewTest")
        self.suggestionTable.alpha = 0
        
        
        
        
        searchBar.backgroundImage = UIImage()
        self.view.ViewBackground(image: "quickLocoBG")

    
    
    //TABLE VIEW
        
        suggestionTable.dataSource = self
        suggestionTable.delegate = self
        
        
        //   let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .//userDomainMask, true).first!
        //  let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        //
        //  let path = documentsDirectoryPath.appendingPathComponent("loco.json")
        
        let path = Bundle.main.path(forResource: "loco", ofType: "json")
        let jsonData =
            NSData(contentsOfMappedFile: path!)
        
        do{
            let object = try JSONSerialization.jsonObject(with: jsonData! as Data, options:  .allowFragments) as? [String:[String:String]]
            
            
            
            readjson(object:object!)
            
            
        }catch{
            print(error)
            
        }
        // configureSearchController()
        //  configureCustomSearchController()
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        for button in view.subviews{
        if button is UIButton {
            UIView.animate(withDuration: 0.5, delay: 0.0,options: [.autoreverse, .allowUserInteraction],
            animations:{
                button.transform = CGAffineTransform(scaleX: 1.1, y:1.1)
                
            }, completion: { (t) -> Void in
                button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            
            
            
            
            }
            
        }
        
    }

    // MARK: - TABLE VIEW
    
    
    func readjson(object: [String:[String:String]]){
        
        
        
        var Businesses = object
        
        for (names,values) in Businesses{
            bizName = names;
            for x in values {
                if (x.key == "Description"){
                    bizDescription = x.value
                }else if (x.key == "TypeOfOrganization"){
                    bizType = x.value
                }
                
            }
            let details =  BusinessDetail(businessName:bizName,businessDescription:bizDescription,businessType:bizType)
            
            businessDetailsArray.append(details);
        }
        
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
        
        
        //   suggestionTable.reload();
        
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
        
        cell.backgroundColor = .clear
        
        return cell;
        
    }
    
    @available(iOS 2.0, *)
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1;
    }


}
