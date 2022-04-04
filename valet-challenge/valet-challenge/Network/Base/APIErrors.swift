//
//  APIErrors.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

enum APIErrors: LocalizedError {
    
    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error(_ code: Int)
    case serverError
    case encodingError(Swift.Error)
    case decodingError
    case urlSessionFailed(_ error: URLError)
    case unknownError
    
}
