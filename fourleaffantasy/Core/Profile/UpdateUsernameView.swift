import SwiftUI

struct UpdateUsernameView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var newFullName: String = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        Form {
            Section(header: Text("New Username")) {
                TextField("Enter new username", text: $newFullName)
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            Button(action: updateUsername) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Update Username")
                }
            }
            .disabled(newFullName.isEmpty || isLoading)
        }
        .navigationTitle("Update Username")
        .onAppear {
            newFullName = viewModel.currentUser?.fullName ?? ""
        }
    }
    
    func updateUsername() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                try await viewModel.updateUsername(newFullName: newFullName)
                dismiss()
            } catch {
                errorMessage = "Failed to update username."
            }
            isLoading = false
        }
    }
}

#Preview {
    UpdateUsernameView().environmentObject(AuthViewModel())
}
