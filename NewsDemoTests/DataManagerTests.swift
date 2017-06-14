//
//  NewsDemoTests.swift
//  NewsDemoTests
//
//  Created by Zafra, Guillermo (Consultant) on 14/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import XCTest
@testable import NewsDemo

class DataManagerTests: XCTestCase {
    
    var dataManager: DataManager?
    
    override func setUp() {
        super.setUp()
        
        dataManager = DataManager()
    }
    
    override func tearDown() {
        
        dataManager = nil
        super.tearDown()
    }
    
    func testFetchTopStories() {
        testExpectation(description: "Fetching top stories from server", actionBlock: { (expectation) in
            dataManager?.fetchTopStories(resultBlock: { (articles) in
                XCTAssertNotNil(articles)
                XCTAssertGreaterThanOrEqual(articles.count, 0)
                expectation.fulfill()
            }) { (error) in
                XCTFail()
            }
        }, waitFor: 5.0)
    }
    
}
