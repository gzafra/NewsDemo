//
//  AsyncImageViewModelTests.swift
//  NewsDemo
//
//  Created by Guillermo Zafra on 15/06/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import XCTest
@testable import NewsDemo

class AsyncImageViewModelTests: XCTestCase {
    private let expectedDelay: TimeInterval = 5.0 // Expected delay to load images.
    
    func testAsyncImageViewModel() {
        let urlTest = "https://static01.nyt.com/images/2017/06/15/world/14USBriefing-London/14USBriefing-London-thumbStandard.jpg"
        
        let asyncImageViewModel = AsyncImageViewModel(urlString: urlTest)
        
        XCTAssertNotNil(asyncImageViewModel.urlString)
        XCTAssertNil(asyncImageViewModel.image)
        XCTAssertNil(asyncImageViewModel.receipt)
    }
    
    func testAsyncImageLoadingSuccess() {
        let urlTest = "https://static01.nyt.com/images/2017/06/15/world/14USBriefing-London/14USBriefing-London-thumbStandard.jpg"
        
        let asyncImageViewModel = AsyncImageViewModel(urlString: urlTest)
        
        XCTAssertNotNil(asyncImageViewModel.urlString)
        XCTAssertNil(asyncImageViewModel.image)
        XCTAssertNil(asyncImageViewModel.receipt)
        
        testExpectation(description: "Loading image asynchronously", actionBlock: { (expectation) in
            asyncImageViewModel.beginThumbnailRequest { (image) in
                XCTAssertNotNil(image)
                XCTAssertNotNil(asyncImageViewModel.image)
                XCTAssertNil(asyncImageViewModel.receipt)
                expectation.fulfill()
            }
        }, waitFor: expectedDelay)
        

    }
    
    func testAsyncImageLoadingCancelled() {
        let urlTest = "https://static01.nyt.com/images/2017/06/15/world/14USBriefing-London/14USBriefing-London-thumbStandard.jpg"
        
        let asyncImageViewModel = AsyncImageViewModel(urlString: urlTest)
        
        XCTAssertNotNil(asyncImageViewModel.urlString)
        XCTAssertNil(asyncImageViewModel.image)
        XCTAssertNil(asyncImageViewModel.receipt)
        
        testExpectation(description: "Loading image asynchronously", actionBlock: { (expectation) in
            asyncImageViewModel.beginThumbnailRequest { (image) in
                XCTFail()
            }
            asyncImageViewModel.cancelThumbnailRequest()
            XCTAssertNil(asyncImageViewModel.image)
            XCTAssertNotNil(asyncImageViewModel.receipt)
            expectation.fulfill()
        }, waitFor: expectedDelay)
    }
    
    func testAsyncImageLoadingFailed() {
        let urlTest = "https://static01.nyt.com/images/2017/06/15/world/14USBriefing-London/WRONGIMAGE.jpg"
        
        let asyncImageViewModel = AsyncImageViewModel(urlString: urlTest)
        
        XCTAssertNotNil(asyncImageViewModel.urlString)
        XCTAssertNil(asyncImageViewModel.image)
        XCTAssertNil(asyncImageViewModel.receipt)
        
        testExpectation(description: "Loading image asynchronously", actionBlock: { (expectation) in
            asyncImageViewModel.beginThumbnailRequest { (image) in
                XCTAssertNil(image)
                XCTAssertNil(asyncImageViewModel.image)
            }

            // Request will time out. Test that image is still not loaded after usual delay
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + expectedDelay, execute: {
                XCTAssertNil(asyncImageViewModel.image)
                expectation.fulfill()
            })
        }, waitFor: expectedDelay + 1.0)
    }
    
}
