//
//  NetworkTarget.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

protocol NetworkTarget {
    
    var baseURL: URL { get }
    
    var path: String  { get }
    
    var type: NetworkRequestType { get }
    
    var method: HTTPMethod { get }
    
    var headers: [String: String]? { get }
    
}

extension NetworkTarget {
    
    var request: URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL.absoluteString) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        
        guard let finalURL = urlComponents.url else { return nil }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        switch type {
        case .requestParameters(let parameters):
            return request.encoded(parameters: parameters)
        case .JSONEncodable(let object):
            _ = try? request.encoded(encodable: object)
        default:
            break
        }
        
        return request
    }
    
}
