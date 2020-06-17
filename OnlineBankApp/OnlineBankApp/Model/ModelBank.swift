
//  ModelBank.swift
//  OnlineBankApp
//
//  Created by Dream Store on 28.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import Foundation
import UIKit

let urlString = "http://resources.finance.ua/ru/public/currency-cash.json"

struct ModelBank: Decodable {
    var sourceId: String?
    var organizations: [Organization]?
    var date: String?
    var regions = [String: String]()
    var cities = [String: String]()
    var currencies = [String: String]()
}

struct Organization: Codable {
    var id: String?
    var oldId: Int?
    var orgType: Int?
    var branch: Bool?
    var title: String?
    var regionId: String?
    var cityId: String?
    var phone: String?
    var address: String?
    var link: String?
    var currencies = [String: [String: String]]()
    var region: String?
    var city: String?
}

class DataManeger {
    var regions = [String: String]()
    var cities = [String: String]()
    var currencies = [String: String]()
    var arrayData = [Organization]()
    static var shared = DataManeger()
    
    func save(array: [Organization]) {
        let encodedUserDetails = try? JSONEncoder().encode(array)
        UserDefaults.standard.set(encodedUserDetails, forKey: "organization")
    }
    
    func loadData () -> [Organization]? {
        if let decodedData = UserDefaults.standard.object(forKey: "organization") as? Data {
            if let organizationDetail = try? JSONDecoder().decode([Organization].self, from: decodedData) {
                arrayData = organizationDetail
                return arrayData
            }
        }
        return nil
    }
}

