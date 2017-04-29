//
//  MapTableViewCell.swift
//  Yard Sale 00
//
//  Created by Nick J Cameron on 2017-02-20.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var businessTitle: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
