//
//  API_Manager.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import Foundation
import SystemConfiguration
import Alamofire
import SainiUtils

public class APIManager {
    
    static let sharedInstance = APIManager()
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func getMultipartHeader() -> [String:String]{
        return ["Content-Type":"multipart/form-data"]
    }
    
    func getJsonHeader() -> [String:String]{
        return ["Content-Type":"application/json"]
    }
    
    func networkErrorMsg()
    {
        log.error("You are not connected to the internet")/
//        displayToast("You are not connected to the internet")
    }
    
    //MARK:- ERROR CODES
    func handleError(errorCode: Int) -> String {
        switch errorCode {
        case 101:
            return "Missing Required Properties"
        case 102:
            return "Connection Error"
        case 103:
            return "Requested user not found"
        case 104:
            return "Username/Password error"
        case 105:
            return "Nothing Modified/ No changes Made"
        case 106:
            return "Invalid Access Token"
        case 107:
            return "This Email id is already registered."
        case 108:
            return "Invalid OTP type."
        case 109:
            return "Token not verified."
        case 110:
            return "Email id already verified."
        case 111:
            return "Verficiation code try has been expired. Request a new token."
        case 112:
            return "verification code has been expired. Token expires in 24 hours."
        case 113:
            return "Invlid URL provided for verification."
        case 114:
            return "Broken reference found."
        case 115:
            return "Profile seems to have missing region data or you are trying to post in wrong region."
        case 400:
            return "Malformed Authorization token error when token in invalid or has been expired."
        case 500:
            return "Generic error or some default error"
            
        default:
            return ""
        }
        
    }
    
    //MARK:- I_AM_COOL_GET
    func I_AM_COOL_GET(params: [String: Any], api: String, Loader: Bool, isMultipart:Bool, _ completion: @escaping (_ dictArr: Data?) -> Void){
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        
        if Loader == true{
            DispatchQueue.main.async {
               showLoader()
            }
        }
        
        let headerParams: HTTPHeaders = HTTPHeaders.init([String : String]())
        let Params:[String: Any] = [String: Any]()
        
        log.success("WORKING_THREAD:->>>>>>> \(Thread.current.threadName)")/
        log.info("HEADERS: \(Log.stats()) \(headerParams)")/
        log.info("API: \(Log.stats()) \(api)")/
        log.info("PARAMS: \(Log.stats()) \(Params)")/
        
        AF.request(api, method: .get, encoding: JSONEncoding.default, headers: headerParams).responseJSON { (response) in
            
            DispatchQueue.main.async {
                removeLoader()
            }
            
            switch response.result {
            case .success:
                log.ln("prettyJSON Start \n")/
                log.result("\(String(describing: response.data?.sainiPrettyJSON))")/
                log.ln("prettyJSON End \n")/
              DispatchQueue.main.async {
                    completion(response.data)
                }
            case .failure(let error):
                log.error("\(Log.stats()) \(error)")/
                
                break
            }
        }
    }
}
