//
//  TruckListingViewModel.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import Foundation
import SainiUtils

protocol TruckListingDelegate {
    var success: Box<Bool> { get set }
    func fetchTruckInfoList()
}

struct TruckListingViewModel: TruckListingDelegate {
    var success: Box<Bool> = Box(Bool())
    
    func fetchTruckInfoList() {
        DispatchQueue.global().async {
            APIManager.sharedInstance.I_AM_COOL_GET(params: [String : Any](), api: API.BASE_URL, Loader: true, isMultipart: false) { (response) in
                print(response)
//                if response != nil{                             //if response is not empty
//                    do {
//                        let success = try JSONDecoder().decode(<#ModelName#>.self, from: response!) // decode the response into model
//                        switch success.code{
//                        case 100:
//                            <#code#>
//                            break
//                        default:
//                            log.error("\(Log.stats()) \(success.message)")/
//                        }
//                    }
//                    catch let err {
//                        log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
//                    }
//                }
            }
        }
    }
    
}
