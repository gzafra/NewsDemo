//
//  XCTestCaseExtensions.swift
//  NewsDemo
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    //MARK: - utilities
    func testExpectation(description: String, actionBlock:(XCTestExpectation)->(), waitFor timeout: TimeInterval) {
        let expectation = self.expectation(description: description)
        actionBlock(expectation)
        waitForExpectations(timeout: timeout) { (error) in
            XCTAssertNil(error)
        }
    }
}
