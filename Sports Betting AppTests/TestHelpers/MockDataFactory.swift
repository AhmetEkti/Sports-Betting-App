//
//  MockDataFactory.swift
//  Sports Betting App
//
//  Created by Ahmet Ekti on 10/15/24.
//

@testable import Sports_Betting_App

func createMockEvent(id: String, homeTeam: String, awayTeam: String) -> BettingEvent {
    BettingEvent(
        id: id,
        sportKey: "football_superlig",
        sportTitle: "Süper Lig",
        commenceTime: "2024-10-15T15:00:00Z",
        homeTeam: homeTeam,
        awayTeam: awayTeam,
        bookmakers: []
    )
}
