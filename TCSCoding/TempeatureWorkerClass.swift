//
//  TempeatureWorkerClass.swift
//  TCSCoding
//
//  Created by Rohith Kumar on 4/2/21.
//

import Foundation


enum HTTPError: Error {
    case invalidURL
    case invalidResponse(Data?, URLResponse?)
}

class TempeatureWorkerClass {
    
    func getValueFromServer(urlValue: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlValue) else {
            completionBlock(.failure(HTTPError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil  else {
                completionBlock(.failure(HTTPError.invalidResponse(data, response)))
                return
            }
            guard let responseData = data else {
                completionBlock(.failure(HTTPError.invalidResponse(data, response)))
                return
            }
            DispatchQueue.main.async {
                completionBlock(.success(responseData))
            }
        }
        task.resume()
    }
}
