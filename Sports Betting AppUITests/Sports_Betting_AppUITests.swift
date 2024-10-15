//
//  Sports_Betting_AppUITests.swift
//  Sports Betting AppUITests
//
//  Created by Ahmet Ekti on 10/5/24.
//

import XCTest

final class Sports_Betting_AppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testTabbar() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["0 Match - 0.00 Odds"].tap()
        tabBar.buttons["Bulletin"].tap()
    }
}
