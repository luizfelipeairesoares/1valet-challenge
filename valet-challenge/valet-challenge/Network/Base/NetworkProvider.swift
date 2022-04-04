//
//  NetworkProvider.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation
import OSLog

struct NetworkProvider: NetworkProviderProtocol {
    
    var urlSession: URLSession
    
    public init(session: URLSession = .shared) {
        self.urlSession = session
    }
    
    func request<T: NetworkTarget>(target: T, completion: @escaping (Result<NetworkResponse, APIErrors>) -> Void) {
        guard let request = target.request else {
            completion(.failure(APIErrors.badRequest))
            return
        }
        os_log("Request: \(request.description)")
        self.urlSession.dataTask(with: request) { result in
            switch result {
            case .success(let (response, data)):
                os_log("Response: \(response.description)")
                let networkResponse = NetworkResponse(
                    statusCode: response.statusCode, data: data,
                    request: request,
                    response: response
                )
                completion(.success(networkResponse))
            case .failure(let error):
                completion(.failure(handleError(error)))
            }
        }.resume()
    }
    
    // MARK: - Private functions
    
    private func handleError(_ error: Error) -> APIErrors {
        switch error {
        case is Swift.DecodingError:
            return .decodingError
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as APIErrors:
            return error
        default:
            return .unknownError
        }
    }
    
}
