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
    
    // Example data for demonstration
    let picksData = [
        (player: "Carter Steffen", favorite: "Dallas Cowboys -7.5", underdog: "Los Angeles Rams +3.0", over: "Over 52.0", under: "Under 52.0", picked: "Dallas Cowboys"),
        (player: "Alex Smith", favorite: "Buffalo Bills -3.5", underdog: "Miami Dolphins +3.5", over: "Over 48.0", under: "Under 48.0", picked: "Miami Dolphins")
    ]
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                ZStack(alignment: .bottomTrailing) {
                    ScrollView {
                        VStack(spacing: 0) {
                            // Header row
                            HStack(spacing: 0) {
                                Text("Name").font(.headline).foregroundColor(Color("TextNavy")).frame(maxWidth: .infinity)
                                Text("Favorite").font(.headline).foregroundColor(Color("TextNavy")).frame(maxWidth: .infinity)
                                Text("Underdog").font(.headline).foregroundColor(Color("TextNavy")).frame(maxWidth: .infinity)
                                Text("Over").font(.headline).foregroundColor(Color("TextNavy")).frame(maxWidth: .infinity)
                                Text("Under").font(.headline).foregroundColor(Color("TextNavy")).frame(maxWidth: .infinity)
                            }
                            .padding(.vertical, 8)
                            .background(Color("CardSurface"))
                            // Picks rows
                            ForEach(picksData, id: \.player) { pick in
                                PicksRowView(
                                    player: pick.player,
                                    favorite: pick.favorite,
                                    underdog: pick.underdog,
                                    over: pick.over,
                                    under: pick.under,
                                    picked: pick.picked
                                )
                            }
                        }
                        .padding(.top)
                        .background(Color("Background").ignoresSafeArea())
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                // display a modal
                                showingSheet.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title.weight(.semibold))
                                    .padding()
                                    .background(Color("PrimaryGreen"))
                                    .foregroundColor(Color("TextNavy"))
                                    .clipShape(Circle())
                                    .shadow(radius: 4, x: 0, y: 4)
                            }
                            .padding(.bottom, 80) // Add extra bottom padding to sit above the tab bar
                            .padding(.trailing, 16)
                        }
                    }
                    .ignoresSafeArea(edges: .horizontal)
                    .sheet(isPresented: $showingSheet, content: {
                        SheetView(name: user.fullName)
                    })
                }
                .navigationTitle("Picks")
                .background(Color("Background").ignoresSafeArea())
            }
        }
    }
}

#Preview {
    PicksView()
        .environmentObject(AuthViewModel())
}
