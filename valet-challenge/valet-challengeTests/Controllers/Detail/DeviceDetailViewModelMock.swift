//
//  DeviceDetailViewModelMock.swift
//  valet-challengeTests
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import Foundation
@testable import valet_challenge

class DeviceDetailViewModelMock: DeviceDetailViewModelProtocol {
    
    let device: Device
    let service: DeviceServiceProtocol
    
    weak var viewController: DeviceDetailVCProtocol?
    
    // MARK: - Init
    
    required init(device: Device) {
        self.device = device
        let mockService = NetworkProviderMock(mockedData: Utils.loadJSON(from: DeviceDetailViewModelMock.self, name: "devices"))
        self.service = DeviceService(session: mockService)
    }
    
    // MARK: - Functions
    
    func assignView(_ view: DeviceDetailVCProtocol) {
        viewController = view
        viewController?.showDevice()
    }
    
}
