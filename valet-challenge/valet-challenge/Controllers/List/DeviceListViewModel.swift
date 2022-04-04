//
//  DeviceListViewModel.swift
//  valet-challenge
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation

protocol DeviceListViewModelProtocol {
    
    var devices: [Device] { get }
    var service: DeviceServiceProtocol { get }
    
    init(service: DeviceServiceProtocol)
    
    func assignView(_ view: DeviceListVCProtocol)
    func requestDevices()
    func searchForDevices(_ searchText: String?)
    
}

class DeviceListViewModel: DeviceListViewModelProtocol {
    
    // MARK: - Variables/Properties
    
    let service: DeviceServiceProtocol
    var devices: [Device]
    
    private var allDevices: [Device]
    private var isFiltering: Bool
    private weak var viewController: DeviceListVCProtocol?
    
    // MARK: - Init
    
    required init(service: DeviceServiceProtocol) {
        self.service = service
        self.devices = []
        self.allDevices = []
        self.isFiltering = false
    }
    
    // MARK: - Functions
    
    func assignView(_ view: DeviceListVCProtocol) {
        self.viewController = view
        requestDevices()
    }
    
    func requestDevices() {
        service.listDevices { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let devices):
                    self?.allDevices = devices
                    self?.devices = devices
                    devices.isEmpty ? self?.viewController?.showEmptyView() : self?.viewController?.reloadDevices()
                case .failure(let error):
                    self?.viewController?.showError(error.localizedDescription)
                }
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
