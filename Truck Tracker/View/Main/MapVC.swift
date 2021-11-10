//
//  MapVC.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapVC: UIViewController {
    
    private var locationManager:CLLocationManager?
    private var truckListVM: TruckListingViewModel = TruckListingViewModel()
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
        mapView.isMyLocationEnabled = true
        getUserLocation()
        truckListVM.fetchTruckInfoList()
        
        truckListVM.success.bind { [weak self](_) in
            guard let `self` = self else { return }
            if self.truckListVM.success.value {
                self.markerSetUp()
            }
        }
    }
    
    //MARK: -  markerSetUp
    func markerSetUp() {
        self.mapView.clear()
        truckListVM.truckListArr.value.forEach { (loc) in
            addMarkersOnMap(lat: loc.lastWaypoint.lat, long: loc.lastWaypoint.lng, data: loc)
        }
    }
    
    //MARK:- addMarkersOnMap
    private func addMarkersOnMap(lat:Double,long:Double, data: TruckListInfo){
        let marker = GMSMarker()
        switch data.lastRunningState.truckRunningState {
        case .running:
            marker.icon = #imageLiteral(resourceName: "green_marker")
        case .stopped:
            marker.icon = #imageLiteral(resourceName: "blue_marker")
        case .idle:
            marker.icon = #imageLiteral(resourceName: "yellow_marker")
        case .error:
            marker.icon = #imageLiteral(resourceName: "red_marker")
        }
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.userData = data
        marker.map = mapView
    }
    
    //MARK: - getUserLocation
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.showsBackgroundLocationIndicator = false
        locationManager?.startUpdatingLocation()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
    }
    
    //MARK: - listBtnIsPressed
    @IBAction func listBtnIsPressed(_ sender: UIBarButtonItem) {
        let vc: ListVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.ListVC.rawValue) as! ListVC
        vc.truckListVM = truckListVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - CLLocationManagerDelegate
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Getting latest location Regular
        if let location = locations.last{
            mapView.camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 10)
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
