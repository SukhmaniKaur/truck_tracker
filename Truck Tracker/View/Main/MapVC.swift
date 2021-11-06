//
//  MapVC.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController {

    // OUTLETS
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    //MARK: - configUI
    private func configUI() {
        
    }
    
    //MARK: - listBtnIsPressed
    @IBAction func listBtnIsPressed(_ sender: UIBarButtonItem) {
        let vc: ListVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.ListVC.rawValue) as! ListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
