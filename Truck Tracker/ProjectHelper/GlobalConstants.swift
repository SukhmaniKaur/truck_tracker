//
//  GlobalConstants.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import Foundation
import UIKit

//MARK: - STORYBOARD
struct STORYBOARD {
    static let MAIN = UIStoryboard(name: "Main", bundle: nil)
}

//MARK: - TABLE_VIEW_CELL
enum TABLE_VIEW_CELL: String {
    case ListCell
}

//MARK: - MAIN_STORYBOARD
enum MAIN_STORYBOARD: String {
    case MapVC, ListVC
}

//MARK:- AppColors
struct AppColors{
    static let LoaderColor =  #colorLiteral(red: 0.8117647059, green: 0.3725490196, blue: 0.3725490196, alpha: 1)
}

//MARK:- DocumentDefaultValues
struct DocumentDefaultValues{
    struct Empty{
        static let string =  ""
        static let int =  0
        static let bool = false
        static let double = 0.0
    }
}

//MARK: - TRUCK_RUNNING_STATE
enum TRUCK_RUNNING_STATE: Int, Encodable{
    case running = 1
    case stopped = 0
    case idle = 2
    case error = 3
}

//MARK: - STATIC_LABELS
enum STATIC_LABELS: String {
    case running = "Running since last "
    case stopped = "Stopped since last "
}
