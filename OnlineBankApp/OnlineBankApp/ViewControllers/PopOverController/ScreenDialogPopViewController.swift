//
//  ScreenDialogPopViewController.swift
//  OnlineBankApp
//
//  Created by Dream Store on 03.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
import MessageUI

final class ScreenDialogPopViewController: UIViewController {
    
    //MARK: - Properties
    var dataSource = Organization()
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var shareButton: UIButton!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureButton()
    }
    
    //MARK: - Methods
    private func registerCell() {
        tableView.register(UINib(nibName: "ScreenDialogCurrenciesCell", bundle: nil), forCellReuseIdentifier: "currcies")
        tableView.register(UINib(nibName: "ScrrenDialogCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    private func configureButton() {
        shareButton.setTitleColor(UIColor(hexString: "f06292"), for: .normal)
        shareButton.backgroundColor = UIColor(hexString: "b0bec5")
        shareButton.addTarget(self, action: #selector(mail), for: .touchUpInside)
    }
    
    @objc private func mail() {
        if MFMailComposeViewController.canSendMail() {
            let region = dataSource.region
            let city = dataSource.city
            let bank1 = region! + "," + city!
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["xxxxxx@xxxxxxxxxx.com"])
            mail.setSubject("Any Subject")
            mail.setMessageBody(bank1, isHTML: true)
            present(mail, animated: true)
        } else {
            return
        }
    }
}

//MARK: - UITableViewDataSource
extension ScreenDialogPopViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numbersCell = dataSource.currencies.count + 1
        return numbersCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScrrenDialogCell
            cell.setupCell(bank: dataSource)
            return cell
        }
            let cell = tableView.dequeueReusableCell(withIdentifier: "currcies", for: indexPath) as! ScreenDialogCurrenciesCell
            if indexPath.row >= 1 {
                let index = dataSource.currencies.index(dataSource.currencies.startIndex, offsetBy: indexPath.row - 1)
                let name = dataSource.currencies.keys[index]
                cell.setupCell(key: name, currency: dataSource.currencies[name]!)
                return cell
        }
        return UITableViewCell()
    } 
}

//MARK: - MFMailComposeViewControllerDelegate
extension ScreenDialogPopViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
