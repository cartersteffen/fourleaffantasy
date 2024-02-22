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
        LeaderboardRowView(rank: 1, player: "Matt Dorn", wins: 37, losses: 16, draws: 2 )
    }
}

#Preview {
    LeaderboardView()
}
