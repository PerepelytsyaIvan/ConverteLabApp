//
//  ConverterLabCell.swift
//  OnlineBankApp
//
//  Created by Dream Store on 29.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
import SafariServices

protocol ConverterLabCellDelegate {
    func didTappedOnButton(from cell: ConverterLabCell, index: Int)
//    func transitionMapView(from cell: ConverterLabCell)
//    func callToTheBank(from cell: ConverterLabCell)
   // func detailViewController(from cell: ConverterLabCell)
}

final class ConverterLabCell: UITableViewCell {
  
    //MARK: - @IBOutlets
    @IBOutlet weak private var bankNameLabel: UILabel!
    @IBOutlet weak private var regionBankLabel: UILabel!
    @IBOutlet weak private var cityBankLabel: UILabel!
    @IBOutlet weak private var buttonBarView: UIView!
    @IBOutlet weak private var addressBankLabel: UILabel!
    @IBOutlet weak private var phoneNumberBankLabel: UILabel!
    @IBOutlet var barButtons: [UIButton]!
    
    
    //MARK - Properties
    var delegate: ConverterLabCellDelegate?
 
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
        buttonBarView.backgroundColor = UIColor.init(hexString: "b0bec5", alpha: 1.0)
    }

    //MARK: - Methods

    
    private func configureButton() {
        for button in barButtons {
            button.backgroundColor = UIColor(hexString: "b0bec5")
        }
    }
    
    func setupCell(bank: Organization) {
        bankNameLabel.text = bank.title
        regionBankLabel.text = bank.region
        cityBankLabel.text = bank.city
        addressBankLabel.text = ("Адрес: \(bank.address ?? "")")
        phoneNumberBankLabel.text = ("Тел: \(bank.phone ?? "")")
    }
    
    //MARK: - @IBActions
    @IBAction func linkButton(_ sender: UIButton) {
        delegate?.didTappedOnButton(from: self, index: 0)
    }
    
    @IBAction func detailButton(_ sender: UIButton) {
        delegate?.didTappedOnButton(from: self, index: 1)
    }
    
    @IBAction func phoneButton(_ sender: UIButton) {
       delegate?.didTappedOnButton(from: self, index: 2)
    }
    
    @IBAction func mapButton(_ sender: UIButton) {
 delegate?.didTappedOnButton(from: self, index: 3)
    }
}
