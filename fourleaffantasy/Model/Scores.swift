//
//  Scores.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/26/24.
//

import Foundation

struct Game : Codable {
    let id: String
    let sport_key: String
    let sport_title: String
    let commence_time: String
    let completed: Bool
    let home_team: String
    let away_team: String
    let scores: [Game]
    let last_update: String
}

struct Score : Codable {
    let name: String
    let score: String
}
