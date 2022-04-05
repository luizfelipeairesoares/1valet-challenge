//
//  DeviceListViewModelTests.swift
//  valet-challengeTests
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import XCTest
@testable import valet_challenge

class DeviceListVM: DeviceListViewModel {
    
    var didAssignView: Bool = false
    
    override func assignView(_ view: DeviceListVCProtocol) {
        super.assignView(view)
        didAssignView = true
    }
    
}

class DeviceListViewModelTests: XCTestCase {
    
    var sut: DeviceListVM!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let mockService = NetworkProviderMock(mockedData: Utils.loadJSON(from: DeviceListViewModelTests.self, name: "device"))
        sut = DeviceListVM(service: DeviceService(session: mockService))
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testAssignView() {
        let viewController = DeviceListViewController(viewModel: sut)
        sut.assignView(viewController)
        XCTAssertTrue(sut.didAssignView)
    }
    
    func testRequestDevices() {
        sut.requestDevices()
        let result = waitToPresent("Test after 5 seconds", timeout: 1.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertFalse(sut.devices.isEmpty)
        } else {
            XCTFail("Delay interrupted")
        }
    }

}
