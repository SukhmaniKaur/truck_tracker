//
//  AppDelegate.swift
//  Truck Tracker
//
//  Created by MACBOOK on 05/11/21.
//

import UIKit
import GoogleMaps
import NVActivityIndicatorView

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var activityLoader : NVActivityIndicatorView!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(MAP_API_KEY.key.rawValue)
        return true
    }
}

extension AppDelegate {
    func sharedDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func showLoader()
    {
        removeLoader()
        DispatchQueue.main.async { [self] in
            self.window?.isUserInteractionEnabled = false
            self.activityLoader = NVActivityIndicatorView(frame: CGRect(x: ((self.window?.frame.size.width)!-50)/2, y: ((self.window?.frame.size.height)!-50)/2, width: 50, height: 50))
            self.activityLoader.type = .ballSpinFadeLoader
            self.activityLoader.color = AppColors.LoaderColor
            self.window?.addSubview(self.activityLoader)
            self.activityLoader.startAnimating()
        }
    }
    
    func removeLoader()
    {
        DispatchQueue.main.async { [self] in
            self.window?.isUserInteractionEnabled = true
            if self.activityLoader == nil {
                return
            }
            self.activityLoader.stopAnimating()
            self.activityLoader.removeFromSuperview()
            self.activityLoader = nil
        }
    }
}
