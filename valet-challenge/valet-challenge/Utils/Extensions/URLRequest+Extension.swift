//
//  URLRequest+Extension.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

extension URLRequest {

    mutating func encoded(encodable: Encodable, encoder: JSONEncoder = JSONEncoder()) throws -> URLRequest {
        do {
            let encodableObject = EncodableObject(encodable)
            httpBody = try encoder.encode(encodableObject)

            let contentTypeHeaderName = "Content-Type"
            if value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }

            return self
        } catch {
            throw APIErrors.encodingError(error)
        }
    }

    func encoded(parameters: [String: Any]) -> URLRequest {
        var newURLRequest = URLRequest(url: self.url!)
        newURLRequest.httpMethod = self.httpMethod
        newURLRequest.allHTTPHeaderFields = self.allHTTPHeaderFields
        guard !parameters.isEmpty else { return self }
        if var components = URLComponents(url: newURLRequest.url!, resolvingAgainstBaseURL: false) {
            var queryItems: [URLQueryItem] = []
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            components.queryItems = queryItems
            newURLRequest.url = components.url
        }
        return newURLRequest
    }
    
}
