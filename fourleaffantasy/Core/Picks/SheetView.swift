//
//  SheetView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/25/24.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @State private var picks = Picks(favorite: "Select", underdog: "Select", over: "Select", under: "Select")
    @State private var viewModel = ViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    private var userName: String
    
    init(name: String) {
        userName = name
    }
    
    let favorites = ["Cowboys -7.5", "Lions -3.0", "Bills -10.5", "Eagles -3.0"]
    let underdogs = ["Packers +7.5", "Rams +3.0", "Steelers +10.5", "Buccaneers +3.0"]
    let over = ["Packers/Cowboys Over 51.0", "Rams/Lions Over 52.0", "Steelers/Bills Over 37.5", "Eagles/Buccaneers Over 43.0"]
    let under = ["Packers/Cowboys Under 51.0", "Rams/Lions Under 52.0", "Steelers/Bills Under 37.5", "Eagles/Buccaneers Under 43.0"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select a Favorite", selection: $picks.favorite) {
                    ForEach(favorites, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
                Picker("Select a Underdog", selection: $picks.underdog) {
                    ForEach(underdogs, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
                Picker("Select a Over", selection: $picks.over) {
                    ForEach(over, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
                Picker("Select a Under", selection: $picks.under) {
                    ForEach(under, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
            }
            .navigationTitle("\(userName)'s Picks")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Done") {
                Task {
                    try await viewModel.savePicks(picks: picks)
                }
            })
        }
    }
}

#Preview {
    SheetView(name: "Matt Dorn")
        .environmentObject(AuthViewModel())
}
