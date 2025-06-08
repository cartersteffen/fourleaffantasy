import SwiftUI

struct UpdatePasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        Form {
            Section(header: Text("New Password")) {
                SecureField("Enter new password", text: $newPassword)
                SecureField("Confirm new password", text: $confirmPassword)
            }
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            Button(action: updatePassword) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Update Password")
                }
            }
            .disabled(!formIsValid || isLoading)
        }
        .navigationTitle("Update Password")
    }
    
    var formIsValid: Bool {
        !newPassword.isEmpty && newPassword == confirmPassword && newPassword.count >= 6
    }
    
    func updatePassword() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                try await viewModel.updatePassword(newPassword: newPassword)
                dismiss()
            } catch {
                errorMessage = "Failed to update password."
            }
            isLoading = false
        }
    }
}

#Preview {
    UpdatePasswordView().environmentObject(AuthViewModel())
}
