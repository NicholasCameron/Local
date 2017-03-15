

import CoreData
import UIKit
import Foundation

class RecommendationTableViewCell: UITableViewCell {

    @IBOutlet weak var imageInCell: UIImageView!
    @IBOutlet weak var cellSeperatorView: UIView!
    @IBOutlet weak var lblBuinessTitle: UILabel!
    @IBOutlet weak var lblBusinessDescription: UILabel!
    @IBOutlet weak var imageCollapseExpande: UIImageView!
    @IBOutlet weak var btnName_Profile: UIButton!

    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnName_Profile(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
      
        
        
    }
}
    
    










