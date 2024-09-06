//
//  AppScreen.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/9/24.
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case leaderboard
    case matchups
    case picks
    case profile
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .leaderboard:
            Label("Leaderboard", systemImage: "trophy")
        case .matchups:
            Label("Matchups", systemImage: "sportscourt")
        case .picks:
            Label("Picks", systemImage: "football")
        case .profile:
            Label("Profile", systemImage: "person.crop.circle")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .leaderboard:
            LeaderboardView()
        case .matchups:
            MatchupsView()
        case .picks:
            PicksView()
        case .profile:
            ProfileView()
        }
    }
}
