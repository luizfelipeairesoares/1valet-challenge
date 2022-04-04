//
//  NetworkRequestType.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

enum NetworkRequestType {
    
    case plainRequest
    
    case requestParameters(parameters: [String: Any])
    
    case JSONEncodable(Encodable)
    
}
