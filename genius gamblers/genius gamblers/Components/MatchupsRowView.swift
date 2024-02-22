//
//  MatchupsRowView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct MatchupsRowView: View {
    let homeTeam: String
    let awayTeam: String
    var title: String {
        return awayTeam + " at " + homeTeam
    }
    let spread: Double
    let moneyline: Int
    let overUnder: Double
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            HStack(spacing: 12) {
                
                Text(String(spread))
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(String(moneyline))
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(String(overUnder))
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    MatchupsRowView(homeTeam: "Rams", awayTeam: "Lions", spread: 3.0, moneyline: 144, overUnder: 52.0)
}
