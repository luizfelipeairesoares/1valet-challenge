//
//  DeviceAPI.swift
//  valet-challenge
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

enum DeviceAPI {
    
    case listDevices
    
}

extension DeviceAPI: NetworkTarget {
    
    var baseURL: URL {
        return URL(string: "https://dl.dropbox.com/s/ho11yptibsyjgxo/")!
    }
    
    var path: String {
        switch self {
        case .listDevices:
            return "devices.json?dl=0"
        }
    }
    
    var type: NetworkRequestType {
        return .plainRequest
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
