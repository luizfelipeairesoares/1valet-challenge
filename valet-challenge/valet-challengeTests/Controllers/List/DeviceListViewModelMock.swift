//
//  DeviceListViewModelMock.swift
//  valet-challengeTests
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import Foundation
@testable import valet_challenge

class DeviceListViewModelMock: DeviceListViewModelProtocol {
    
    let service: DeviceServiceProtocol
    var devices: [Device]
    var allDevices: [Device]
    var isFiltering: Bool
    
    weak var viewController: DeviceListVCProtocol?
    
    // MARK: - Init
    
    required init(service: DeviceServiceProtocol) {
        self.allDevices = []
        self.devices = []
        self.isFiltering = false
        let mockService = NetworkProviderMock(mockedData: Utils.loadJSON(from: DeviceListViewModelMock.self, name: "devices"))
        self.service = DeviceService(session: mockService)
    }
    
    // MARK: - Functions
    
    func assignView(_ view: DeviceListVCProtocol) {
        viewController = view
    }
    
    func requestDevices() {
        service.listDevices { [weak self] result in
            switch result {
            case .success(let devices):
                self?.allDevices = devices
                self?.devices = devices
                self?.viewController?.reloadDevices()
            case .failure(let error):
                self?.viewController?.showError(error.localizedDescription)
            }
        }
    }
    
    func searchForDevices(_ searchText: String?) {
        guard let searchText = searchText, searchText.count > 2 else {
            if isFiltering {
                devices = allDevices
                viewController?.reloadDevices()
            }
            isFiltering = false
            return
        }
        isFiltering = true
        devices = allDevices.filter({ $0.title.lowercased().contains(searchText.lowercased()) })
        viewController?.reloadDevices()
    }
    
}
