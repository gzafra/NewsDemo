//
//  NewsDemoUITests.swift
//  NewsDemoUITests
//
//  Created by Guillermo Zafra on 02/12/2017.
//  Copyright © 2017 gzp. All rights reserved.
//

import XCTest

class NewsDemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Senate Passes Sweeping Republican Tax Overhaul Bill"]/*[[".cells.staticTexts[\"Senate Passes Sweeping Republican Tax Overhaul Bill\"]",".staticTexts[\"Senate Passes Sweeping Republican Tax Overhaul Bill\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Show full article"].tap()
        app.navigationBars["NewsDemo.FullArticleView"].buttons["Back"].tap()
        app.navigationBars["NewsDemo.DetailView"].buttons["Top Stories"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(app.navigationBars["Top Stories"].exists)
    }
    
}
