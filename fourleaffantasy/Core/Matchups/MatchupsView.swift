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
            VStack {
                HStack {
                    Button(action: {
                        if viewModel.selectedWeek > 1 {
                            viewModel.selectWeek(viewModel.selectedWeek - 1)
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("TextNavy"))
                    }
                    .disabled(viewModel.selectedWeek == 1)
                    Text("Week \(viewModel.selectedWeek)")
                        .font(.headline)
                        .foregroundColor(Color("TextNavy"))
                        .frame(minWidth: 80)
                    Button(action: {
                        if viewModel.selectedWeek < viewModel.totalWeeks {
                            viewModel.selectWeek(viewModel.selectedWeek + 1)
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("TextNavy"))
                    }
                    .disabled(viewModel.selectedWeek == viewModel.totalWeeks)
                }
                .padding(.vertical)
                List {
                    ForEach(viewModel.matchups, id: \.id) { matchup in
                        MatchupsRowView(matchup: matchup)
                    }
                }
                .listStyle(.plain)
                .background(Color("Background"))
            }
            .onAppear {
                Task {
                    await viewModel.fetchMatchups()
                }
            }
            .navigationTitle("Matchups")
            // Removed redundant background modifier for cleaner UI adjustments
        }
    }
}

#Preview {
    MatchupsView()
}
