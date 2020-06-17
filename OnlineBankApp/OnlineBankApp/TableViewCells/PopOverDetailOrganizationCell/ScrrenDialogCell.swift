//
//  ScrrenDialogCell.swift
//  OnlineBankApp
//
//  Created by Dream Store on 03.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class ScrrenDialogCell: UITableViewCell {

    //MARK: - @IBOutlet
    @IBOutlet private weak var bankTitleLabel: UILabel!
    @IBOutlet private weak var regionLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!

    //MARK: - Methods
    func setupCell(bank: Organization) {
        bankTitleLabel.text = bank.title
        regionLabel.text = bank.region
        cityLabel.text = bank.city
    }
}
