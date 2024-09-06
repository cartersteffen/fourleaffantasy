//
//  LeaderboardView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                VStack(spacing: 16) {
                    HeaderView()
                    LeaderboardRowView(rank: 1, player: user.fullName, wins: 37, losses: 16, draws: 2 )
                    Spacer()
                }
                .navigationTitle("Leaderboard")
            }
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Player")
                .font(.subheadline)
            Text("Record")
                .font(.subheadline)
            Text("Points")
                .font(.subheadline)
            Text("Earnings")
                .font(.subheadline)
            
        }
    }
}

#Preview {
    LeaderboardView()
        .environmentObject(AuthViewModel())
}
