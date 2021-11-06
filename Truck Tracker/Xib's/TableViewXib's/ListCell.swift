//
//  ListCell.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import UIKit

class ListCell: UITableViewCell {

    // OUTLETS
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var lastUpdatedLbl: UILabel!
    @IBOutlet weak var movingStateLbl: UILabel!
    @IBOutlet weak var vehicleNumberLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
