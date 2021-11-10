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
    var truckListArr: Box<[TruckListInfo]> { get set }
    var searchedListArr: Box<[TruckListInfo]> { get set }
    func fetchTruckInfoList()
}

struct TruckListingViewModel: TruckListingDelegate {
    var searchedListArr: Box<[TruckListInfo]> = Box([TruckListInfo]())
    var success: Box<Bool> = Box(Bool())
    var truckListArr: Box<[TruckListInfo]> = Box([TruckListInfo]())
    
    func fetchTruckInfoList() {
        DispatchQueue.global().async {
            APIManager.sharedInstance.I_AM_COOL_GET(params: [String : Any](), api: API.BASE_URL, Loader: true, isMultipart: false) { (response) in
                if response != nil{                             //if response is not empty
                    do {
                        let success = try JSONDecoder().decode(TruckListResponse.self, from: response!) // decode the response into model
                        switch success.responseCode.responseCode{
                        case 200:
                            self.calculateLastRunningTime(arr: success.data)
                            self.success.value = true
                            break
                        default:
                            log.error("\(Log.stats()) \(success.responseCode.message)")/
                        }
                    }
                    catch let err {
                        log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
                    }
                }
            }
        }
    }
    
    func calculateLastRunningTime(arr: [TruckListInfo]) {
        var listArr = arr
        for index in 0..<listArr.count {
            listArr[index].lastRunningState.lastRunningTime = sainiTimesAgo(Double(listArr[index].lastRunningState.stopStartTime / 1000))
        }
        self.truckListArr.value = listArr
    }
    
    
    func runningSearch(array: [TruckListInfo], search: String) {
        self.searchedListArr.value = array.filter({ (string) -> Bool in
            return string.truckNumber.lowercased().contains(search.lowercased())
        })
    }
}
