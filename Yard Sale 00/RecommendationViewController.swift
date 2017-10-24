import CoreData
import UIKit
import Foundation

class RecommendationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,RecommendationProtocol  {

    
    
    @IBOutlet weak var recommendationTableView: UITableView!

    
    var isCellTapped = false
    var currentRowSelected = -1
    var selectedRowIndex = -1
    
    var previousRowSelected = -1
    var cellSelected = false
    var previousRow = false
    var previousCell:RecommendationTableViewCell?
    var cellIndex = Int()
    var filteredBusinesses:[Businesses]?
    var isFiltered = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()

        recommendationTableView.delegate = self
        recommendationTableView.dataSource = self
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
 
        
    }
   
    
    
   override func viewWillAppear(_ animated: Bool) {
    if filteredBusinesses != nil{
        isFiltered = true
        recommendationTableView.reloadData()
    }
    }
    
    //MARK:table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if !isFiltered{
        return AppController.shared.externalBusinesses.count
        }else{
            return (filteredBusinesses?.count)!
        }
    }
    
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var businesses = [Businesses]()
        if !isFiltered{
            businesses = AppController.shared.externalBusinesses
        }else{
            businesses = filteredBusinesses!
        }

        
        let cellIdentifier = "recommendationCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecommendationTableViewCell
        let headerImage = UIImage(data: businesses[indexPath.row]._businessImage!)
        cell.imageInCell.image = headerImage
        cell.lblBuinessTitle.text = businesses[indexPath.row]._businessName?.capitalized
        cell.lblBusinessDescription.text = businesses[indexPath.row]._businessDescription
        cell.lblBusinessDescription.sizeToFit()
        cell.itemIndex = indexPath.row
        cell.delegate = self
        //  configureCell(cell, indexPath: indexPath)
        
        return cell
        
    }
    
    
    @available(iOS 2.0, *)
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIndex = indexPath.row
        if cellSelected == false{
            cellSelected = true
        }else{
            
            if(previousCell?.cellSeperatorView.isHidden == true && previousCell != tableView.cellForRow(at: indexPath) as? RecommendationTableViewCell ){
                previousCell?.cellSeperatorView.isHidden = false
                previousCell?.imageCollapseExpande.image  = UIImage(named: "downArrow")
            }
            
            
            if  previousRowSelected == currentRowSelected{
                previousRow = true
            }
            
            previousRowSelected = currentRowSelected
            
            if  previousRowSelected == currentRowSelected && previousRow == true{
                previousRowSelected = -1
                previousRow = false
            }
            
            
        }
        
        
        //gets the selected row
        currentRowSelected = indexPath.row
        
        
        let cell = tableView.cellForRow(at: indexPath) as! RecommendationTableViewCell
        
        previousCell = cell
        
        
        if cell.imageCollapseExpande.image == UIImage(named: "upArrow"){
            cell.imageCollapseExpande.image  = UIImage(named: "downArrow")
            cell.cellSeperatorView.isHidden = false
            
        }else{
            cell.cellSeperatorView.isHidden = true
            cell.imageCollapseExpande.image  = UIImage(named: "upArrow")
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if previousRowSelected == currentRowSelected{
            
            return 160
        }else{
            
            if indexPath.row == previousRowSelected {
                return 160
            }else if indexPath.row == currentRowSelected{
                
                
                return UITableViewAutomaticDimension
            }
        }
        
        
        return 160
    }
    
    
    func didTapOnItem() {
        
        var businesses = [Businesses]()
        if !isFiltered{
            businesses = AppController.shared.externalBusinesses
        }else{
            businesses = filteredBusinesses!
        }
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "profile") as! ProfileViewController

        myVC.business =  businesses[cellIndex]

        self.navigationController?.pushViewController(myVC, animated: true)

        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
