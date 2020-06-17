//
//  DetailBankCell.swift
//  OnlineBankApp
//
//  Created by Dream Store on 02.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

class DetailBankCell: UITableViewCell {
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var bankLabel: UILabel!
    @IBOutlet private weak var bankWebsite: UILabel!
    @IBOutlet private weak var adressBankLabel: UILabel!
    @IBOutlet private weak var telBankLabel: UILabel!
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        bankLabel.textColor = UIColor(hexString: "ff4081")
    }
    
    //MARK: - Methods
    func setupCell(bank: Organization) {
        bankLabel.text = bank.title
        bankWebsite.text = "Официальный сайт банка:\n\(bank.link ?? "")"
        adressBankLabel.text = "Адрес: \(bank.address ?? "")"
        telBankLabel.text = "Телефон: \(bank.phone ?? "")"
    }
    
}
