//
//  NetworkProviderMock.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation
@testable import valet_challenge

struct NetworkProviderMock: NetworkProviderProtocol {
    
    var urlSession: URLSession
    
    let mockedData: Data?
    
    init(urlSession: URLSession = .shared, mockedData: Data?) {
        self.urlSession = urlSession
        self.mockedData = mockedData
    }
    
    func request<T: NetworkTarget>(target: T, completion: @escaping (Result<NetworkResponse, APIErrors>) -> Void) {
        guard let urlRequest = target.request else {
            completion(.failure(.badRequest))
            return
        }
        if let data = mockedData {
            let networkResponse = NetworkResponse(
                statusCode: 200,
                data: data,
                request: urlRequest,
                response: nil
            )
            completion(.success(networkResponse))
        } else {
            urlSession.dataTask(with: urlRequest) { result in
                switch result {
                case .success(let (response, data)):
                    let networkResponse = NetworkResponse(
                        statusCode: response.statusCode, data: data,
                        request: urlRequest,
                        response: response
                    )
                    completion(.success(networkResponse))
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }.resume()
        }
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
