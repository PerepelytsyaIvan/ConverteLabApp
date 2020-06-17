//
//  CurrencyTableViewCell.swift
//  OnlineBankApp
//
//  Created by Dream Store on 02.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class CurrencyTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var indexOrganization = Int()
    var dataSource = Organization()
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTableView()
    }
    
    //MARK: - Methods
    private func configureTableView() {
        tableView.register(UINib(nibName: "CourseCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

//MARK: - UITableViewDataSource
extension CurrencyTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseCell
        let index = dataSource.currencies.index(dataSource.currencies.startIndex, offsetBy: indexPath.row)
        let name = dataSource.currencies.keys[index]
        cell.index = indexOrganization
        cell.setupCell(key: name, currency: dataSource.currencies[name]!, title: dataSource.title!)
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CurrencyTableViewCell: UITableViewDelegate {
}
