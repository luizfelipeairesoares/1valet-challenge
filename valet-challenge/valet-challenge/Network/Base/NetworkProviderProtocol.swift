//
//  NetworkProviderProtocol.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

struct NetworkResponse {
    
    let statusCode: Int
    
    let data: Data
    
    let request: URLRequest?
    
    let response: HTTPURLResponse?
    
}

extension NetworkResponse {
    
    func mapJSON<D: Decodable>(using decoder: JSONDecoder = JSONDecoder()) throws -> D {
        do {
            let object: D = try decoder.decode(D.self, from: data)
            return object
        } catch(let errorThrown) {
            print(errorThrown)
            throw APIErrors.decodingError
        }
    }
    
}

protocol NetworkProviderProtocol {
    
    var urlSession: URLSession { get }
    
    func request<T: NetworkTarget>(target: T, completion: @escaping (Result<NetworkResponse, APIErrors>) -> Void)
    
}
