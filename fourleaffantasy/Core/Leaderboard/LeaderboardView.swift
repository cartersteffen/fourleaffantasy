//
//  LeaderboardView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    // Example leaderboard data for demonstration
    let leaderboardData = [
        (rank: 1, player: "Carter Steffen", wins: 37, losses: 16, draws: 2),
        (rank: 2, player: "Alex Smith", wins: 32, losses: 20, draws: 3),
        (rank: 3, player: "Jamie Lee", wins: 28, losses: 24, draws: 2)
    ]
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                ZStack(alignment: .bottomTrailing) {
                    ScrollView {
                        VStack(spacing: 0) {
                            // Header row
                            HStack(spacing: 0) {
                                Text("Player").font(.headline).foregroundColor(Color("TextNavy")).frame(maxWidth: .infinity)
                                Text("Record").font(.headline).foregroundColor(Color("TextNavy")).frame(maxWidth: .infinity)
                                Text("Points").font(.headline).foregroundColor(Color("TextNavy")).frame(maxWidth: .infinity)
                                Text("Earnings").font(.headline).foregroundColor(Color("TextNavy")).frame(maxWidth: .infinity)
                            }
                            .padding(.vertical, 8)
                            .background(Color("CardSurface"))
                            // Leaderboard rows
                            ForEach(leaderboardData, id: \.player) { row in
                                LeaderboardRowView(
                                    rank: row.rank,
                                    player: row.player,
                                    wins: row.wins,
                                    losses: row.losses,
                                    draws: row.draws
                                )
                            }
                        }
                        .padding(.top)
                        .background(Color("Background").ignoresSafeArea())
                    }
                    // Floating action button (optional, for visual consistency)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                // Add leaderboard action here if needed
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title.weight(.semibold))
                                    .padding()
                                    .background(Color("PrimaryGreen"))
                                    .foregroundColor(Color("TextNavy"))
                                    .clipShape(Circle())
                                    .shadow(radius: 4, x: 0, y: 4)
                            }
                            .padding(.bottom, 80)
                            .padding(.trailing, 16)
                        }
                    }
                    .ignoresSafeArea(edges: .horizontal)
                }
                .navigationTitle("Leaderboard")
                .background(Color("Background").ignoresSafeArea())
            }
        }
    }
}


#Preview {
    LeaderboardView()
        .environmentObject(AuthViewModel())
}
