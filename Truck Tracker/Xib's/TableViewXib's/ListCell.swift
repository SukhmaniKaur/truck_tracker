//
//  ListCell.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import UIKit
import SainiUtils

class ListCell: UITableViewCell {

    // OUTLETS
    @IBOutlet weak var kmLbl: UILabel!
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
    
    var listInfo: TruckListInfo = TruckListInfo() {
        didSet {
            vehicleNumberLbl.text = listInfo.truckNumber
            speedLbl.text = "\(listInfo.lastWaypoint.speed)"
            lastUpdatedLbl.text = listInfo.lastRunningState.lastRunningTime
            switch listInfo.lastRunningState.truckRunningState {
            case .running:
                speedLbl.isHidden = false
                kmLbl.isHidden = false
                movingStateLbl.text = STATIC_LABELS.running.rawValue +  listInfo.lastRunningState.lastRunningTime
            case .stopped, .idle, .error:
                kmLbl.isHidden = true
                speedLbl.isHidden = true
                movingStateLbl.text = STATIC_LABELS.stopped.rawValue + listInfo.lastRunningState.lastRunningTime
            }
        }
    }
    
}
