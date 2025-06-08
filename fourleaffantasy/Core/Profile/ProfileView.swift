//
//  ProfileView.swift
//  genius gamblers
//
//  Created by Carter Steffen on 2/8/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                List {
                    Section {
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 72, height: 72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.fullName)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                
                                Text(user.email)
                                    .font(.footnote)
                                    .accentColor(.gray)
                            }
                        }
                    }
                    Section("General") {
                        HStack {
                            SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                            Spacer()
                            Text(appVersionString)
                                .font(.subheadline)
                        }
                    }
                    Section("Account") {
                        NavigationLink(destination: UpdateUsernameView().environmentObject(viewModel)) {
                            SettingsRowView(imageName: "person.crop.circle", title: "Update Username", tintColor: Color(.systemBlue))
                        }
                        NavigationLink(destination: UpdatePasswordView().environmentObject(viewModel)) {
                            SettingsRowView(imageName: "lock.circle", title: "Update Password", tintColor: Color(.systemBlue))
                        }
                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: .red)
                        }
                        Button {
                            viewModel.deleteAccount()
                        } label: {
                            SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                        }
                    }
                }
                .navigationTitle("Profile")
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
