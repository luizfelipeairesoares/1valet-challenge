//
//  NetworkProviderTests.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-03-31.
//

import Foundation
import XCTest
@testable import valet_challenge

class NetworkProviderTests: XCTestCase {
    
    var sut: NetworkProvider!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkProvider(session: .shared)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testRequestSuccess() {
        var success = false
        let expectation = self.expectation(description: "requestSuccessfull")
        sut.request(target: MockAPI.successResponse) { result in
            switch result {
            case .success(let response):
                success = response.statusCode == 200
            case .failure:
                break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertTrue(success)
    }
    
    func testRequestFailure() {
        var success = false
        let expectation = self.expectation(description: "requestFailure")
        sut.request(target: MockAPI.failureResponse) { result in
            switch result {
            case .success:
                break
            case .failure:
                success = true
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertTrue(success)
    }
    
}
