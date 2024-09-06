//
//  MatchupsView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct MatchupsView: View {
    @StateObject private var viewModel = MatchupsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.matchups, id: \.id) { matchup in
                    MatchupsRowView(matchup: matchup)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchMatchups()
                }
            }
            .navigationTitle("Matchups")
        }
    }
}

#Preview {
    MatchupsView()
}
