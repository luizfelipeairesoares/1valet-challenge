//
//  DeviceDetailVCTests.swift
//  valet-challengeTests
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import XCTest
@testable import valet_challenge

class DeviceDetailVCMock: DeviceDetailViewController {
    
    var didShowDevice: Bool = false
    
    override func showDevice() {
        super.showDevice()
        didShowDevice = true
    }
    
}

class DeviceDetailVCTests: XCTestCase {
    
    var device: Device!
    var sut: DeviceDetailVCMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        device = Device(id: "1", type: "Sensor", price: 9.99, currency: "USD", isFavorite: false, imageUrl: URL(string: "https://cdn.rona.ca/images/05225160_L.jpg"), title: "Sensor X", desc: nil)
        sut = DeviceDetailVCMock(viewModel: DeviceDetailViewModelMock(device: device))
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        device = nil
        try super.tearDownWithError()
    }

    func testViewDidLoad() {
        XCTAssertEqual(sut.title, device.title)
        XCTAssertEqual(sut.view.backgroundColor, UIColor.white)
    }
    
    func testShowDevice() {
        sut.showDevice()
        XCTAssertTrue(sut.didShowDevice)
    }

}
