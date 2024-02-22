//
//  PicksView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct PicksView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PicksRowView(player: "Carter Steffen", favorite: "Dallas Cowboys -7.5", underdog: "Los Angeles Rams + 3.0", overUnder: "Rams at Lions U52.0")
            
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }
            .padding()
        }
    }
}

#Preview {
    PicksView()
}
