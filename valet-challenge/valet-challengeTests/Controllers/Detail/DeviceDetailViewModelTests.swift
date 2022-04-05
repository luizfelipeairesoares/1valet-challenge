//
//  DeviceDetailViewModelTests.swift
//  valet-challengeTests
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import XCTest
@testable import valet_challenge

class DeviceDetailVM: DeviceDetailViewModel {
    
    var didAssignView: Bool = false
    
    override func assignView(_ view: DeviceDetailVCProtocol) {
        super.assignView(view)
        didAssignView = true
    }
    
}

class DeviceDetailViewModelTests: XCTestCase {
    
    var sut: DeviceDetailVM!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let device = Device(id: "1", type: "Sensor", price: 9.99, currency: "USD", isFavorite: false, imageUrl: URL(string: "https://cdn.rona.ca/images/05225160_L.jpg"), title: "Sensor X", desc: nil)
        sut = DeviceDetailVM(device: device)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFilm() {
        XCTAssertNotNil(sut.device)
    }
    
    func testAssignView() {
        let viewController = DeviceDetailViewController(viewModel: sut)
        sut.assignView(viewController)
        XCTAssertTrue(sut.didAssignView)
    }

}
