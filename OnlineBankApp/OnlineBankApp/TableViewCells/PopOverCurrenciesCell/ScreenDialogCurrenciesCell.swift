//
//  ScreenDialogCurrenciesCell.swift
//  OnlineBankApp
//
//  Created by Dream Store on 03.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class ScreenDialogCurrenciesCell: UITableViewCell {
    //MARK: - @IBOutlet
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        currencyLabel.textColor = UIColor(hexString: "880e4f")
        moneyLabel.textColor = UIColor(hexString: "78909c")
    }
    //MARK: - Methods
      func setupCell(key: String, currency: [String: String]) {
        currencyLabel.text = key
        guard let currentCourseBid = currency["bid"], let reductionBid = Float(currentCourseBid) else { return }
        guard let currentCourseAsk = currency["ask"], let reductionAsk = Float(currentCourseAsk) else { return }
        
        moneyLabel.text = "\(String(format: "%.2f", reductionBid))/\(String(format: "%.2f", reductionAsk))"
    }
}
