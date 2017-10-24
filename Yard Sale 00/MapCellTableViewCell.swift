//
//  MapCellTableViewCell.swift
//  Yard Sale 00
//
//  Created by Nicholas Cameron on 2017-10-23.
//  Copyright © 2017 Nick J Cameron. All rights reserved.
//

import UIKit

class MapCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
