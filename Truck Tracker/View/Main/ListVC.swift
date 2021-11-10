//
//  ListVC.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import UIKit

class ListVC: UIViewController {
    
    var truckListVM: TruckListingViewModel = TruckListingViewModel()

    // OUTLETS
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: animated)
    }
    
    //MARK: - configUI
    private func configUI() {
        tableView.register(UINib(nibName: TABLE_VIEW_CELL.ListCell.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.ListCell.rawValue)
    }
    
    //MARK: - mapBtnIsPressed
    @IBAction func mapBtnIsPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableView Delegate and DataSource Methods
extension ListVC: UITableViewDelegate, UITableViewDataSource {
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckListVM.truckListArr.value.count
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.ListCell.rawValue, for: indexPath) as? ListCell else { return UITableViewCell() }
        cell.listInfo = truckListVM.truckListArr.value[indexPath.row]
        return cell
    }    
}
