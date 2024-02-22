//
//  PicksRowView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct PicksRowView: View {
    let player: String
    let favorite: String
    let underdog: String
    let overUnder: String
    var body: some View {
        HStack(spacing: 12) {
            
            Text(player)
                .font(.subheadline)
                .foregroundColor(.black)
            Text(favorite)
                .font(.subheadline)
                .foregroundColor(.black)
            Text(underdog)
                .font(.subheadline)
                .foregroundColor(.black)
            Text(overUnder)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    PicksRowView(player: "Carter Steffen", favorite: "Dallas Cowboys -7.5", underdog: "Los Angeles Rams + 3.0", overUnder: "Rams at Lions U52.0")
}
