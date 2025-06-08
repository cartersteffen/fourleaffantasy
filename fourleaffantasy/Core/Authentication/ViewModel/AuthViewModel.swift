//
//  AuthViewModel.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var loginError: String?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            self.loginError = nil
            await fetchUser()
        } catch let error as NSError {
            var errorMessage = error.localizedDescription
            if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                switch errorCode {
                case .wrongPassword:
                    errorMessage = "Incorrect password. Please try again."
                case .invalidEmail:
                    errorMessage = "The email address is badly formatted."
                case .userNotFound:
                    errorMessage = "No account found with this email."
                case .userDisabled:
                    errorMessage = "This account has been disabled."
                case .networkError:
                    errorMessage = "Network error. Please check your connection."
                case .tooManyRequests:
                    errorMessage = "Too many attempts. Please try again later."
                case .credentialAlreadyInUse, .userTokenExpired:
                    // Attempt to refresh token and sign in again
                    if let user = Auth.auth().currentUser {
                        do {
                            try await user.getIDTokenForcingRefresh(true)
                            let result = try await Auth.auth().signIn(withEmail: email, password: password)
                            self.userSession = result.user
                            self.loginError = nil
                            await fetchUser()
                            return
                        } catch {
                            errorMessage = "Session expired. Please try logging in again."
                        }
                    }
                default:
                    break
                }
            }
            self.loginError = errorMessage
            print("DEBUG: Failed to login with error \(errorMessage)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: current user is \(String(describing: self.currentUser))")
    }
    
    func updateUsername(newFullName: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            try await Firestore.firestore().collection("users").document(uid).updateData(["fullName": newFullName])
            await fetchUser()
        } catch {
            print("DEBUG: Failed to update username with error \(error.localizedDescription)")
            throw error
        }
    }
    
    func updatePassword(newPassword: String) async throws {
        guard let user = Auth.auth().currentUser else { return }
        do {
            try await user.updatePassword(to: newPassword)
        } catch {
            print("DEBUG: Failed to update password with error \(error.localizedDescription)")
            throw error
        }
    }
}
