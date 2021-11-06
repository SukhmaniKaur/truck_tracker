//
//  MapVC.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import UIKit
import GoogleMaps
import SainiUtils

class MapVC: UIViewController {
    
    private var locationManager = SainiLocationManager()
    private var longitude: Double = Double()
    private var latitude: Double = Double()
    
    // OUTLETS
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    //MARK: - configUI
    private func configUI() {
        if let currentLocation = locationManager.exposedLocation {
            log.success("\(currentLocation)")/
            mapView.isMyLocationEnabled = true
            latitude = currentLocation.coordinate.latitude
            longitude = currentLocation.coordinate.longitude
            mapView.camera = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 10)
        } else {
            self.view.sainiShowToast(message: "Kindly enable your location services.")
        }
        
    }
    
    //MARK: - listBtnIsPressed
    @IBAction func listBtnIsPressed(_ sender: UIBarButtonItem) {
        let vc: ListVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.ListVC.rawValue) as! ListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
