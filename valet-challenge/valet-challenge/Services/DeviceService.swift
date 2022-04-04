//
//  DeviceService.swift
//  valet-challenge
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

protocol DeviceServiceProtocol: NetworkServiceProtocol {
    
    func listDevices(completion: @escaping (Result<[Device], APIErrors>) -> Void)
    
}

struct DeviceService: DeviceServiceProtocol {
    
    let session: NetworkProviderProtocol
    
    init(session: NetworkProviderProtocol = NetworkProvider()) {
        self.session = session
    }
    
    func listDevices(completion: @escaping (Result<[Device], APIErrors>) -> Void) {
        session.request(target: DeviceAPI.listDevices) { result in
            switch result {
            case .success(let response):
                do {
                    let deviceList: DeviceListAPIResponse = try response.mapJSON()
                    completion(.success(deviceList.devices))
                } catch {
                    completion(.failure(APIErrors.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
