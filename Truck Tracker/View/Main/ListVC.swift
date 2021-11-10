//
//  ListVC.swift
//  Truck Tracker
//
//  Created by MACBOOK on 06/11/21.
//

import UIKit

protocol UpdateMapListDelegate {
    func updateListOnSearch(updatedArr: [TruckListInfo])
}

class ListVC: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    var truckListVM: TruckListingViewModel = TruckListingViewModel()
    private var workItemReferance: DispatchWorkItem?
    private var searchedText: String = String()
    var updateListDelegate: UpdateMapListDelegate?
    
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
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - configUI
    private func configUI() {
        searchController.searchBar.delegate = self
        tableView.register(UINib(nibName: TABLE_VIEW_CELL.ListCell.rawValue, bundle: nil), forCellReuseIdentifier: TABLE_VIEW_CELL.ListCell.rawValue)
        
        truckListVM.truckListArr.bind { [weak self](_) in
            guard let `self` = self else { return }
            if !self.truckListVM.truckListArr.value.isEmpty {
                print("Updated in ListVC truckListArr")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        truckListVM.searchedListArr.bind { [weak self](_) in
            guard let `self` = self else { return }
            if !self.truckListVM.searchedListArr.value.isEmpty {
                print("Updated in ListVC searchedListArr")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - refreshBtnIsPressed
    @IBAction func refreshBtnIsPressed(_ sender: UIBarButtonItem) {
        truckListVM.searchedListArr.value.removeAll()
        truckListVM.truckListArr.value.removeAll()
        truckListVM.fetchTruckInfoList()
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
        if !truckListVM.searchedListArr.value.isEmpty {
            return truckListVM.searchedListArr.value.count
        } else {
            return truckListVM.truckListArr.value.count
        }
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL.ListCell.rawValue, for: indexPath) as? ListCell else { return UITableViewCell() }
        if !truckListVM.searchedListArr.value.isEmpty {
            cell.listInfo = truckListVM.searchedListArr.value[indexPath.row]
        } else {
            cell.listInfo = truckListVM.truckListArr.value[indexPath.row]
        }
        return cell
    }    
}

//MARK: - UISearchControllerDelegate
extension ListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Add your search logic here
        print(searchText)
        truckListVM.searchedListArr.value.removeAll()
        if !searchText.isEmpty {
            workItemReferance?.cancel()
            let workItem = DispatchWorkItem {
                self.truckListVM.runningSearch(array: self.truckListVM.truckListArr.value, search: searchText)
                self.updateListDelegate?.updateListOnSearch(updatedArr: self.self.truckListVM.searchedListArr.value)
            }
            workItemReferance = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1),execute: workItem)
        }
    }
}
