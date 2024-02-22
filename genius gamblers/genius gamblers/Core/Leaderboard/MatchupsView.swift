//
//  MatchupsView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct MatchupsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        MatchupsRowView(homeTeam: "Rams", awayTeam: "Lions", spread: 3.0, moneyline: 144, overUnder: 52.0)
    }
}

#Preview {
    MatchupsView()
}
