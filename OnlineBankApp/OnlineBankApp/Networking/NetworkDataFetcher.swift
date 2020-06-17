//
//  NetworkDataFetcher.swift
//  OnlineBankApp
//
//  Created by Dream Store on 28.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    let networkServise = NetworkService()
    
    func fetchOrganization(urlString: String, response: @escaping (ModelBank?) -> Void) {
        networkServise.request(urlString: urlString) { (resault) in
            switch resault {
            case .success(let data):
                do {
                    let dataBank = try? JSONDecoder().decode(ModelBank.self, from: data)
                    response(dataBank)
                } catch {
                    response(nil)
                }
            case .failure(let error):
                print(error)
                response(nil)
            }
        }
    }
}
