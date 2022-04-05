//
//  DeviceCellTests.swift
//  valet-challengeTests
//
//  Created by Luiz Felipe Aires Soares on 2022-04-04.
//

import XCTest
@testable import valet_challenge

class DeviceCellTests: XCTestCase {
    
    var sut: DeviceCell!
    var device: Device!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DeviceCell(style: .default, reuseIdentifier: DeviceCell.cellId)
        device = Device(id: "1", type: "Sensor", price: 9.99, currency: "USD", isFavorite: false, imageUrl: URL(string: "https://cdn.rona.ca/images/05225160_L.jpg"), title: "Sensor X", desc: nil)
    }

    override func tearDownWithError() throws {
        sut = nil
        device = nil
        try super.tearDownWithError()
    }

    func testSetupCell() {
        sut.setup(device: device)
        XCTAssertEqual(sut.titleLabel.text, device.title)
        let result = waitToPresent("Waiting for image to download", timeout: 2.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(sut.thumbImageView.image)
        } else {
            XCTFail("Delay interrupted")
        }
    }

}
