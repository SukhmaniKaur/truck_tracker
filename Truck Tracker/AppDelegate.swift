//
//  AppDelegate.swift
//  Truck Tracker
//
//  Created by MACBOOK on 05/11/21.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(MAP_API_KEY.key.rawValue)
        return true
    }
}
