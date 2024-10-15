//
//  BettingBasketViewModelTests.swift
//  Sports Betting AppTests
//
//  Created by Ahmet Ekti on 10/15/24.
//

import XCTest
@testable import Sports_Betting_App

class BettingBasketViewModelTests: XCTestCase {
    
    var viewModel: BettingBasketViewModel!
    
    override func setUp() {
        super.setUp()
        setupDependencies()
    }
    
    override func tearDown() {
        cleanUp()
        super.tearDown()
    }
    
    // MARK: - Setup Helpers
    
    private func setupDependencies() {
        viewModel = BettingBasketViewModel.shared
    }
    
    private func cleanUp() {
        viewModel.basket.items.removeAll()
    }
    
    // MARK: - Tests
    
    func testAddToBasket() {
        let event = createMockEvent(id: "1", homeTeam: "Beşiktaş", awayTeam: "Galatasaray")
        let outcome = Outcome(name: "Beşiktaş", price: 1.4)
        let marketType = "MS 1"
        
        viewModel.addToBasket(event: event, outcome: outcome, marketType: marketType)
        
        XCTAssertEqual(viewModel.basket.items.count, 1)
        XCTAssertEqual(viewModel.basket.items.first?.event.id, "1")
        XCTAssertEqual(viewModel.basket.items.first?.selectedOutcome.name, "Beşiktaş")
        XCTAssertEqual(viewModel.basket.items.first?.marketType, "MS 1")
    }
    
    func testRemoveFromBasket() {
        let event = createMockEvent(id: "1", homeTeam: "Galatasaray", awayTeam: "Fenerbahçe")
        let outcome = Outcome(name: "Galatasaray", price: 1.2)
        let marketType = "MS 1"
        
        viewModel.addToBasket(event: event, outcome: outcome, marketType: marketType)
        XCTAssertEqual(viewModel.basket.items.count, 1)

        viewModel.removeFromBasket(at: 0)
        XCTAssertEqual(viewModel.basket.items.count, 0)
    }

}
