//
//  LeaderboardRowView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct LeaderboardRowView: View {
    let rank: Int
    let player: String
    let wins: Int
    let losses: Int
    let draws: Int
    var record: String {
        return "\(wins)-\(losses)-\(draws)"
    }
    var points: Int {
        return (wins * 2) + draws
    }
    var earnings: String {
        var hypothetical = (wins * 100) - (losses * 100) - (draws * 50)
        return "$\(hypothetical)"
    }
    var body: some View {
        HStack(spacing: 12) {
            
            Text(player)
                .font(.subheadline)
                .foregroundColor(.black)
            Text(record)
                .font(.subheadline)
                .foregroundColor(.black)
            Text(String(points))
                .font(.subheadline)
                .foregroundColor(.black)
            Text(earnings)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    LeaderboardRowView(rank: 1, player: "Matt Dorn", wins: 37, losses: 21, draws: 2 )
}
