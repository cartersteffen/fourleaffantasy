//
//  PicksView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct PicksView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showingSheet = false
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                ZStack(alignment: .bottomTrailing) {
                    PicksRowView(player: "Carter Steffen", favorite: "Dallas Cowboys -7.5", underdog: "Los Angeles Rams + 3.0", overUnder: "Rams at Lions U52.0")
                    
                    Button {
                        // display a modal
                        showingSheet.toggle()
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
                    .sheet(isPresented: $showingSheet, content: {
                        SheetView(name: user.fullName)
                    })
                }
                .navigationTitle("Picks")
            }
        }
    }
}

#Preview {
    PicksView()
        .environmentObject(AuthViewModel())
}
