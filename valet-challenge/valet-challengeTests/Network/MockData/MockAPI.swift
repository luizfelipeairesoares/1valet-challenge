//
//  MockAPI.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation
@testable import valet_challenge

enum MockAPI {
    
    case successResponse
    case failureResponse
    
}

extension MockAPI: NetworkTarget {
    
    var baseURL: URL {
        return URL(string: "https://assets.eventbase.com/apps/ios-interview-project/resources/")!
    }
    
    var path: String {
        switch self {
        case .successResponse:
            return "venuelistjson.json"
        case .failureResponse:
            return ""
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
