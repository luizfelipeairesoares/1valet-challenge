//
//  DeviceDetailViewModel.swift
//  valet-challenge
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import Foundation

protocol DeviceDetailViewModelProtocol {
    
    var device: Device { get }
    
    init(device: Device)
    
    func assignView(_ view: DeviceDetailVCProtocol)
    
}

class DeviceDetailViewModel: DeviceDetailViewModelProtocol {
    
    // MARK: - Variables/Properties
    
    let device: Device
    
    private weak var viewController: DeviceDetailVCProtocol?
    
    // MARK: - Init
    
    required init(device: Device) {
        self.device = device
    }
    
    // MARK: - Functions
    
    func assignView(_ view: DeviceDetailVCProtocol) {
        self.viewController = view
        viewController?.showDevice()
    }
    
}
