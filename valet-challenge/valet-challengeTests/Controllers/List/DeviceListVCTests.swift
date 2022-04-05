//
//  DeviceListVCTests.swift
//  valet-challengeTests
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import XCTest
@testable import valet_challenge

class DeviceListVCMock: DeviceListViewController {
    
    var didReloadDevices: Bool = false
    var didShowError: Bool = false
    var didShowEmptyView: Bool = false
    
    override func reloadDevices() {
        super.reloadDevices()
        didReloadDevices = true
    }
    
    override func showError(_ message: String) {
        super.showError(message)
        didShowError = true
    }
    
    override func showEmptyView() {
        super.showEmptyView()
        didShowEmptyView = true
    }
    
}

class DeviceListVCTests: XCTestCase {
    
    var viewModel: DeviceListViewModelMock!
    var sut: DeviceListVCMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let mockService = NetworkProviderMock(mockedData: Utils.loadJSON(from: DeviceListViewModelTests.self, name: "device"))
        viewModel = DeviceListViewModelMock(service: DeviceService(session: mockService))
        sut = DeviceListVCMock(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func testViewDidLoad() {
        XCTAssertEqual(sut.title, "Devices")
    }
    
    func testReloadDevices() {
        sut.reloadDevices()
        let result = waitToPresent("Waiting for devices", timeout: 2.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(sut.tableView.numberOfSections, 1)
            XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), viewModel.devices.count)
            XCTAssertTrue(sut.didReloadDevices)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testShowError() {
        sut.showError("Test Error")
        XCTAssertTrue(sut.didShowError)
    }
    
    func testShowEmptyView() {
        sut.showEmptyView()
        XCTAssertTrue(sut.didShowEmptyView)
    }

}
