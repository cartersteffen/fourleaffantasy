//
//  Odds.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/26/24.
//

import Foundation

struct Matchup : Codable {
    let id: String
    let sport_key: String
    let sport_title: String
    let commence_time: String
    let home_team: String
    let away_team: String
    let bookmakers: [Bookmaker]?
}

struct Bookmaker : Codable {
    let key: String?
    let title: String?
    let last_update: String?
    let markets: [Market]?
}

struct Market : Codable {
    let key: String
    let last_update: String
    let outcomes: [Outcome]
}

struct Outcome : Codable {
    let name: String
    let price: Double
    let point: Double?
}
