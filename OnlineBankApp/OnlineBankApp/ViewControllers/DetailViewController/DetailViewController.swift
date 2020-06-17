//
//  DetailViewController.swift
//  OnlineBankApp
//
//  Created by Dream Store on 02.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.


import UIKit
import SafariServices

final class DetailViewController: UIViewController {
    
    //MARK: Veriable
    var counter = Int()
    var index = Int()
    var dataSource: Organization?
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var arrayButton: [UIButton]!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configureButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_share"), style: .done, target: self, action: #selector(transitionVC))
    }
    
    //MARK: - Methods
    private func configureButton() {
        for button in arrayButton {
            button.clipsToBounds = true
            button.layer.cornerRadius = button.frame.width / 2
            button.layer.shadowColor = UIColor.lightGray.cgColor
            button.layer.shadowOffset = CGSize(width: 5, height: 5)
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1.0
            button.layer.masksToBounds = false
            if button.tag == 0 {
                button.backgroundColor = UIColor(hexString: "ff4081")
            } else {
                button.backgroundColor = UIColor(hexString: "b0bec5")
                button.isHidden = true
            }
        }
    }
    
    private func shadow(cell: UITableViewCell ) {
        cell.contentView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.contentView.layer.shadowOpacity = 1
        cell.contentView.layer.shadowOffset = CGSize.zero
        cell.contentView.layer.shadowRadius = 5
    }
    
    @objc private func transitionVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScreenDialogPopViewController") as! ScreenDialogPopViewController
        vc.modalPresentationStyle = .popover
        let popOver = vc.popoverPresentationController
        vc.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popOver?.delegate = self
        popOver?.sourceView = self.view
        popOver?.sourceRect = CGRect(x: view.center.x, y: view.center.y, width: 0, height: 0)
        vc.preferredContentSize = CGSize(width: 370, height: 480)
        guard let dataSource = dataSource else { return }
        vc.dataSource = dataSource
        present(vc, animated: true)
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "DetailBankCell", bundle: nil), forCellReuseIdentifier: "DetailBankCell")
        tableView.register(UINib(nibName: "CurrencyNameTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyNameTableViewCell")
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
    }
    
    //MARK: - @IBAction
    @IBAction func openButton(_ sender: Any) {
        for button in arrayButton {
            if button.tag > 0 {
                if counter % 2 == 0 {
                    button.isHidden = false
                } else {
                    button.isHidden = true
                }
            } else {
                if counter % 2 == 0 {
                    button.setImage(#imageLiteral(resourceName: "ic_close"), for: .normal)
                } else {
                    button.setImage(#imageLiteral(resourceName: "ic_hamburger"), for: .normal)
                }
            }
        }
        counter += 1
    }
    
    @IBAction func phoneButton(_ sender: UIButton) {
        guard let dataSource = dataSource, let phone = dataSource.phone  else { return }
        if let url = URL(string: "tel://\(phone)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func linkButton(_ sender: UIButton) {
        guard let dataSource = dataSource, let link = dataSource.link  else { return }
        guard let url = URL(string: link) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    @IBAction func markButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        guard let dataSource = dataSource, let address = dataSource.address  else { return }
        vc.adress = address
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = dataSource else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailBankCell", for: indexPath) as! DetailBankCell
            shadow(cell: cell)
            cell.setupCell(bank: dataSource)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyNameTableViewCell", for: indexPath) as! CurrencyNameTableViewCell
            shadow(cell: cell)
            return cell
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell", for: indexPath) as! CurrencyTableViewCell
        shadow(cell: cell)
        cell.dataSource = dataSource
        cell.indexOrganization = index
        return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

//MARK: - UIPopoverPresentationControllerDelegate
extension DetailViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
