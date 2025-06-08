//
//  PicksRowView.swift
//  Four Leaf Fantasy
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct PicksRowView: View {
    let player: String
    let favorite: String
    let underdog: String
    let over: String
    let under: String
    let picked: String
    var body: some View {
        HStack(spacing: 0) {
            Text(player)
                .font(.subheadline)
                .foregroundColor(Color("TextNavy"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(picked == player ? Color("PrimaryGreen").opacity(0.2) : Color("CardSurface"))
                .cornerRadius(6)
            Text(favorite)
                .font(.subheadline)
                .foregroundColor(Color("TextNavy"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(favorite.contains(picked) ? Color("PrimaryGreen").opacity(0.2) : Color("CardSurface"))
                .cornerRadius(6)
            Text(underdog)
                .font(.subheadline)
                .foregroundColor(Color("TextNavy"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(underdog.contains(picked) ? Color("SecondaryYellow").opacity(0.2) : Color("CardSurface"))
                .cornerRadius(6)
            Text(over)
                .font(.subheadline)
                .foregroundColor(Color("TextNavy"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(over.contains(picked) ? Color("AccentOlive").opacity(0.2) : Color("CardSurface"))
                .cornerRadius(6)
            Text(under)
                .font(.subheadline)
                .foregroundColor(Color("TextNavy"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background(under.contains(picked) ? Color("Background").opacity(0.2) : Color("CardSurface"))
                .cornerRadius(6)
        }
        .background(Color("CardSurface"))
    }
}

#Preview {
    PicksRowView(player: "Carter Steffen", favorite: "Dallas Cowboys -7.5", underdog: "Los Angeles Rams + 3.0", over: "Over 52.0", under: "Under 52.0", picked: "Dallas Cowboys -7.5")
}
