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

    func testUpdateExistingItemInBasket() {
        let event = createMockEvent(id: "1", homeTeam: "Beşiktaş", awayTeam: "Galatasaray")
        let outcome1 = Outcome(name: "Beşiktaş", price: 1.4)
        let outcome2 = Outcome(name: "Draw", price: 3.2)
        let marketType1 = "MS 1"
        let marketType2 = "MS X"

        viewModel.addToBasket(event: event, outcome: outcome1, marketType: marketType1)
        XCTAssertEqual(viewModel.basket.items.count, 1)
        XCTAssertEqual(viewModel.basket.items.first?.selectedOutcome.name, "Beşiktaş")

        viewModel.addToBasket(event: event, outcome: outcome2, marketType: marketType2)
        XCTAssertEqual(viewModel.basket.items.count, 1)
        XCTAssertEqual(viewModel.basket.items.first?.selectedOutcome.name, "Draw")
        XCTAssertEqual(viewModel.basket.items.first?.marketType, "MS X")
    }

    func testRemoveItemWhenSameMarketTypeSelected() {
        let event = createMockEvent(id: "1", homeTeam: "Beşiktaş", awayTeam: "Galatasaray")
        let outcome = Outcome(name: "Beşiktaş", price: 1.4)
        let marketType = "MS 1"

        viewModel.addToBasket(event: event, outcome: outcome, marketType: marketType)
        XCTAssertEqual(viewModel.basket.items.count, 1)

        viewModel.addToBasket(event: event, outcome: outcome, marketType: marketType)
        XCTAssertEqual(viewModel.basket.items.count, 0)
    }

    func testIsOutcomeSelected() {
        let event = createMockEvent(id: "1", homeTeam: "Beşiktaş", awayTeam: "Galatasaray")
        let outcome = Outcome(name: "Beşiktaş", price: 1.4)
        let marketType = "MS 1"

        XCTAssertFalse(viewModel.isOutcomeSelected(event: event, marketType: marketType))

        viewModel.addToBasket(event: event, outcome: outcome, marketType: marketType)
        XCTAssertTrue(viewModel.isOutcomeSelected(event: event, marketType: marketType))

        XCTAssertFalse(viewModel.isOutcomeSelected(event: event, marketType: "MS 2"))
    }

    // Helper function to create mock events
    private func createMockEvent(id: String, homeTeam: String, awayTeam: String) -> BettingEvent {
        return BettingEvent(id: id, homeTeam: homeTeam, awayTeam: awayTeam, startTime: Date(), markets: [])
    }
}
