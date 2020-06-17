//
//  ConverterLabViewController.swift
//  OnlineBankApp
//
//  Created by Dream Store on 29.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
import SafariServices
import CoreLocation

final class ConverterLabViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Variables
    private var dataSource = [Organization]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filterOrganization = [Organization]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .done, target: self, action: #selector(search))
        didBecomeActiveNotification()
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "546e7a")
        tableView.register(UINib(nibName: "ConverterLabCell", bundle: nil), forCellReuseIdentifier: "ConverterLabCell")
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didBecomeActiveNotification()
    }
    
    //MARK: - Methods
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.present(searchController, animated: true, completion: nil)
        searchController.searchResultsUpdater = self
    }
    
    @objc private func search() {
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.present(searchController, animated: true, completion: nil)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }
    
    private func didBecomeActiveNotification()  {
        let networkDataFeatcher = NetworkDataFetcher()
        networkDataFeatcher.fetchOrganization(urlString: urlString, response: {[weak self] (bank) in
            guard let organizations = bank?.organizations else { return }
            DataManeger.shared.arrayData = organizations
            DataManeger.shared.regions = bank!.regions
            DataManeger.shared.cities = bank!.cities
            DataManeger.shared.currencies = bank!.currencies
            self?.dataSource = DataManeger.shared.arrayData
            self?.cityAndRegion()
            self?.tableView.reloadData()
        })
    }
    
    private func cityAndRegion() {
        for bank in 0..<dataSource.count {
            let region = DataManeger.shared.regions[dataSource[bank].regionId!]
            let city = DataManeger.shared.cities[dataSource[bank].cityId!]
            dataSource[bank].city = city
            dataSource[bank].region = region
        }
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension ConverterLabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.isEmpty, let organizationLoadData = DataManeger.shared.loadData() {
            dataSource = organizationLoadData
        }
        
        if isFiltering {
            return filterOrganization.count
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConverterLabCell", for: indexPath) as! ConverterLabCell
        cell.contentView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.contentView.layer.shadowOpacity = 1
        cell.contentView.layer.shadowOffset = CGSize.zero
        cell.contentView.layer.shadowRadius = 5
        var organization = Organization()
        
        if isFiltering {
            organization = filterOrganization[indexPath.row]
        } else {
            organization = dataSource[indexPath.row]
        }
        
        cell.setupCell(bank: organization)
        cell.delegate = self
        
        return cell
    }
}

//MARK: - ConverterLabCellDelegate
extension ConverterLabViewController: ConverterLabCellDelegate {
    func didTappedOnButton(from cell: ConverterLabCell, index: Int) {
        switch index {
        case 0:
            let index = tableView.indexPath(for: cell)!.row
            var link = String()
            if isFiltering {
                link = filterOrganization[index].link!
            } else {
                link = DataManeger.shared.arrayData[index].link!
            }
            guard let url = URL(string: link) else { return }
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            let index = tableView.indexPath(for: cell)!.row
            if isFiltering {
                vc.dataSource = filterOrganization[index]
            } else {
                vc.dataSource = dataSource[index]
            }
            vc.index = index
            searchController.isActive = false
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let index = tableView.indexPath(for: cell)!.row
            var phoneNumber: String?
            if isFiltering {
                phoneNumber = filterOrganization[index].phone
            } else {
                phoneNumber = dataSource[index].phone
            }
            guard let phone = phoneNumber, let url = URL(string: phone) else { return }
            searchController.isActive = false
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        case 3:
            let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            let index = tableView.indexPath(for: cell)!.row
            var address: String?
            if isFiltering {
                address = filterOrganization[index].address!
            } else {
                address = dataSource[index].address!
            }
            guard let addressMap = address else { return }
            vc.adress = addressMap
            searchController.isActive = false
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

//MARK: - UISearchResultsUpdating
extension ConverterLabViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContenForSearch(searchController.searchBar.text!)
    }
    
    private func filterContenForSearch(_ searchText: String) {
        filterOrganization = dataSource.filter({ (organization) -> Bool in
            let isFilterName = (organization.title?.lowercased().contains(searchText.lowercased()))!
            let isFilterCity = organization.city?.lowercased().contains(searchText.lowercased())
            let isFilterRegion = organization.region?.lowercased().contains(searchText.lowercased())
            
            if isFilterName {
                return isFilterName
            } else if isFilterCity! {
                return isFilterCity!
            } else {
                return isFilterRegion!
            }
        })
        tableView.reloadData()
    }
}
