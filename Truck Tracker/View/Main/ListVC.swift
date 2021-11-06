//
//  ListVC.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import UIKit

class ListVC: UIViewController {

    // OUTLETS
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    //MARK: - configUI
    private func configUI() {
        
    }
    
    //MARK: - mapBtnIsPressed
    @IBAction func mapBtnIsPressed(_ sender: UIBarButtonItem) {
    }
}
