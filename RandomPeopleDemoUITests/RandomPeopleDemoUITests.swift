//
//  RandomPeopleDemoUITests.swift
//  RandomPeopleDemoUITests
//
//  Created by Boyko Andrey on 5/27/17.
//  Copyright © 2017 aboiko. All rights reserved.
//

import XCTest

class RandomPeopleDemoUITests: XCTestCase {
        
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
    
    func testOpenDetailInfo() {
        let app = XCUIApplication()
        //get first cell
        let elements =  app.staticTexts.matching(identifier: "baseCellTitleLabel")
        let element = elements.element(boundBy: 0)
        //get user name
        let userName = element.label
        //open new screen
        element.tap()
        //check
        XCTAssertNotNil(app.otherElements.containing(.navigationBar, identifier:userName))
    }
}
