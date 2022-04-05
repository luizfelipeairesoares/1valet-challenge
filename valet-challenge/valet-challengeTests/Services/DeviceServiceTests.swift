//
//  DeviceServiceTests.swift
//  valet-challengeTests
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import XCTest
@testable import valet_challenge

class DeviceServiceTests: XCTestCase {
    
    var sut: DeviceService!

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testListDevicesWithMockedData() {
        guard let jsonData = Utils.loadJSON(from: DeviceServiceTests.self, name: "devices") else {
            XCTFail("Unable to load mocked JSON file")
            return
        }
        sut = DeviceService(session: NetworkProviderMock(mockedData: jsonData))
        var success = false
        let expectation = self.expectation(description: "requestSuccessfull")
        sut.listDevices { result in
            switch result {
            case .success:
                success = true
            case .failure:
                break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertTrue(success)
    }

}
