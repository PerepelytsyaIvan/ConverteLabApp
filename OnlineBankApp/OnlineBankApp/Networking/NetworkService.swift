//
//  NetworkService.swift
//  OnlineBankApp
//
//  Created by Dream Store on 28.05.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import Foundation

class NetworkService {
    func request(urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
            }.resume()
    }
}
