//
//  URLSession+Extension.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

extension URLSession {
    
    func dataTask(with request: URLRequest, completion: @escaping (Result<(HTTPURLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: request) { data, urlResponse, error in
            if let err = error {
                completion(.failure(err))
                return
            }
            guard let response = urlResponse as? HTTPURLResponse, let data = data else {
                completion(.failure(APIErrors.badRequest))
                return
            }
            if !(200...299).contains(response.statusCode) {
                completion(.failure(APIErrors.error(response.statusCode)))
                return
            }
            completion(.success((response, data)))
        }
    }
    
}
