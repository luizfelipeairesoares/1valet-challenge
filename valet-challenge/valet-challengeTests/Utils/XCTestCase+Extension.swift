//
//  XCTestCase+Extension.swift
//
//  Created by Luiz Felipe Aires Soares on 2022-04-02.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func waitToPresent(_ desc: String, timeout: TimeInterval) -> XCTWaiter.Result {
        let exp = expectation(description: desc)
        return XCTWaiter.wait(for: [exp], timeout: timeout)
    }
    
}
