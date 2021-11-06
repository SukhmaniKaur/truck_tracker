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

//MARK: - MAP_API_KEY
enum MAP_API_KEY: String {
    case key = "AIzaSyCCw6-syRJVpK7fFsYOO8BJpfkdh5wId2A"
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
