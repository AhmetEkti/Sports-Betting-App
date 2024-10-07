//
//  BettingDashboardViewModel.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/5/24.
//

import Foundation
import Combine

class BettingDashboardViewModel {
    @Published var bettingEvents: [BettingEventCellViewModel] = []
    @Published var filteredBettingEvents: [BettingEventCellViewModel] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let networkManager: NetworkManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchBettingEvents() {
        isLoading = true
        let request = BetsListRequest(regions: "eu", markets: "h2h")
        
        networkManager.request(request)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.errorDescription
                    print("Error fetching betting events: \(error.errorDescription)")
                case .finished:
                    print("Betting events fetch completed")
                }
            } receiveValue: { [weak self] (response: BettingResponse) in
                self?.processBettingEvents(response)
                print("Received \(response.count) betting events")
            }
            .store(in: &cancellables)
    }
    
    private func processBettingEvents(_ events: [BettingEvent]) {
        let sortedEvents = events.sorted { $0.commenceTimeDate ?? Date() < $1.commenceTimeDate ?? Date() }
        
        var cellViewModels: [BettingEventCellViewModel] = []
        var previousEvent: BettingEvent? = nil
        
        for event in sortedEvents {
            let cellViewModel = BettingEventCellViewModel(event: event, previousEvent: previousEvent)
            cellViewModels.append(cellViewModel)
            previousEvent = event
        }
        
        self.bettingEvents = cellViewModels
        self.filteredBettingEvents = cellViewModels
    }
    
    func filterEvents(with searchText: String) {
        if searchText.isEmpty {
            filteredBettingEvents = bettingEvents
        } else {
            filteredBettingEvents = bettingEvents.filter { event in
                event.event.homeTeam.lowercased().contains(searchText.lowercased()) ||
                event.event.awayTeam.lowercased().contains(searchText.lowercased()) ||
                event.event.sportTitle.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
