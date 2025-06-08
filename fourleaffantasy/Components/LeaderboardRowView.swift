//
//  LeaderboardRowView.swift
//  Four Leaf Fantasy
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
        let hypothetical = (wins * 100) - (losses * 100) - (draws * 50)
        return "$\(hypothetical)"
    }
    var body: some View {
        HStack(spacing: 0) {
            Text(player)
                .font(.subheadline)
                .foregroundColor(Color("TextNavy"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color("CardSurface"))
                .cornerRadius(6)
            Text(record)
                .font(.subheadline)
                .foregroundColor(Color("TextNavy"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color("CardSurface"))
                .cornerRadius(6)
            Text(String(points))
                .font(.subheadline)
                .foregroundColor(Color("TextNavy"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color("CardSurface"))
                .cornerRadius(6)
            Text(earnings)
                .font(.subheadline)
                .foregroundColor(Color("TextNavy"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(Color("CardSurface"))
                .cornerRadius(6)
        }
        .background(Color("CardSurface"))
    }
}

#Preview {
    LeaderboardRowView(rank: 1, player: "Matt Dorn", wins: 37, losses: 21, draws: 2 )
}
