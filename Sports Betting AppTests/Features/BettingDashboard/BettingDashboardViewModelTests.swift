//
//  BettingDashboardViewControllerTests.swift
//  Sports Betting AppTests
//
//  Created by Ahmet Ekti on 10/15/24.
//

import XCTest
@testable import Sports_Betting_App

class BettingDashboardViewModelTests: XCTestCase {
    
    var viewModel: BettingDashboardViewModel!
    
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
        viewModel = BettingDashboardViewModel()
    }
    
    private func cleanUp() {
        viewModel = nil
    }
    
    // MARK: - Tests

    func testFilterEvents() {
        let event1 = createMockEvent(id: "1", homeTeam: "Trabzon", awayTeam: "Fenerbahçe")
        let event2 = createMockEvent(id: "2", homeTeam: "Beşiktaş", awayTeam: "Galatasaray")
        viewModel.bettingEvents = [
            BettingEventCellViewModel(event: event1, previousEvent: nil),
            BettingEventCellViewModel(event: event2, previousEvent: event1)
        ]
        
        viewModel.filterEvents(with: "Galatasaray")
        XCTAssertEqual(viewModel.filteredBettingEvents.count, 1)
        XCTAssertEqual(viewModel.filteredBettingEvents.first?.event.awayTeam, "Galatasaray")
        
        viewModel.filterEvents(with: "Bodrum Spor")
        XCTAssertEqual(viewModel.filteredBettingEvents.count, 0)
        XCTAssertEqual(viewModel.bettingEvents.count, 2)
    }
}


