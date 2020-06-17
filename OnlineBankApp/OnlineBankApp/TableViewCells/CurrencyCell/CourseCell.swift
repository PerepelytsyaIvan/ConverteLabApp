//
//  CourseCell.swift
//  OnlineBankApp
//
//  Created by Dream Store on 03.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit

final class CourseCell: UITableViewCell {

    //MARK: - @IBOutlet
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var nameCurrency: UILabel!
    @IBOutlet private var indicatorUIImage: [UIImageView]!
    
    //MARK: - Properties
    var index = Int()
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Methods
    func setupCell(key: String, currency: [String: String], title: String) {
        guard let currentCourseBid = currency["bid"], let reductionBid = Float(currentCourseBid) else { return }
        guard let currentCourseAsk = currency["ask"], let reductionAsk = Float(currentCourseAsk) else { return }
        
        nameCurrency.text = key
        currencyLabel.text = "\(String(format: "%.2f", reductionBid))\n\(String(format: "%.2f", reductionAsk))"
        
        guard  let organizations = DataManeger.shared.loadData() else { return }
        let currencyUserDefaults = organizations[index].currencies
        let money = currencyUserDefaults[key]

        guard let previousCourseBid = money?["bid"], let courseBid = Float(previousCourseBid) else { return }
        guard let previousCourseAsk = money?["ask"], let courseAsk = Float(previousCourseAsk) else { return }
        
        if courseBid < reductionBid {
          indicatorUIImage[0].image = #imageLiteral(resourceName: "ic_arrow_drop_up")
        } else if courseBid > reductionBid {
             indicatorUIImage[0].image = #imageLiteral(resourceName: "ic_arrow_down")
        }
        
        if courseAsk < reductionAsk {
             indicatorUIImage[1].image = #imageLiteral(resourceName: "ic_arrow_drop_up")
        } else if courseAsk > reductionAsk {
             indicatorUIImage[1].image = #imageLiteral(resourceName: "ic_arrow_down")
        }
    }
}
