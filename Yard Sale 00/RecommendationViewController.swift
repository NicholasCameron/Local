import CoreData
import UIKit
import Foundation

class RecommendationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    
    
    @IBOutlet weak var recommendationTableView: UITableView!

    
    var isCellTapped = false
    var currentRowSelected = -1
    var selectedRowIndex = -1
    
    var previousRowSelected = -1
    var cellSelected = false
    var previousRow = false
    var previousCell = RecommendationTableViewCell()

    
     var Users = [AddBusiness]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Add BEVER HEADING
        
//        let frame = CGRect(x: 0, y: 0, width: 60, height: 60)
//        print("frame \(frame)")
//        let beaverImage = UIImageView(frame: frame)
//        beaverImage.image = UIImage(named: "beaver")
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
//        titleView.addSubview(beaverImage)
//        
//        self.navigationItem.titleView = titleView
//        
        
        let manageData = CoreDataManager();
     
        Users = manageData.getUsers()
        
        
        
        
        // Do any additional setup after loading the view.
        
        recommendationTableView.delegate = self
        recommendationTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
 
        
    }
   
    
    
    
    
    /////////////   TABLE VIEW DELEGATES     ////////////////
    
    //MARK: -Table View Delegates
    
    
    
    
    /////////////   TABLE VIEW DELEGATES     ////////////////
    
    //MARK: -Table View Delegates
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return Users.count
    }
    
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        
        let cellIdentifier = "recommendationCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecommendationTableViewCell
        var headerImage = UIImage(data: Users[indexPath.row].image as Data)
        cell.imageInCell.image = headerImage
        cell.lblBuinessTitle.text = Users[indexPath.row].businessName
        cell.lblBusinessDescription.text = "this is dummy text is all that the whole point of writing this text out like a dummy when i could have just copy pasted intread of wasting all my dog funk time to copy paste"
        cell.lblBusinessDescription.sizeToFit()
        
        //  configureCell(cell, indexPath: indexPath)
        
        return cell
        
    }
    
    
    @available(iOS 2.0, *)
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if cellSelected == false{
            
            cellSelected = true
        }else{
            
            if(previousCell.cellSeperatorView.isHidden == true && previousCell != tableView.cellForRow(at: indexPath) as! RecommendationTableViewCell ){
                previousCell.cellSeperatorView.isHidden = false
                previousCell.imageCollapseExpande.image  = UIImage(named: "downArrow")
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
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
