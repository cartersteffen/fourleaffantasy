//
//  PicksViewModel.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/25/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

extension SheetView {
    @Observable
    class ViewModel {
        
        init() {
        }
        
        func savePicks(picks: Picks) async throws {
            do {
                let encodedPicks = try Firestore.Encoder().encode(picks)
                try await Firestore.firestore().collection("picks").document().setData(encodedPicks)
            } catch {
                print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            }
        }
        
    }
}
