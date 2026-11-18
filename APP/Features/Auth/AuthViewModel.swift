import SwiftUI
import Observation
import UIKit

@Observable
@MainActor
public final class AuthViewModel {
    public var mode: AuthMode = .login
    public var phone: String = ""
    public var email: String = ""
    public var password: String = ""
    public var confirmPassword: String = ""
    
    public var isProcessing: Bool = false
    public var errorMessage: String?
    public var showRegistrationAnimation: Bool = false
    
    public init() {}
    
    public var isPasswordMatching: Bool {
        !password.isEmpty && password == confirmPassword
    }
    
    public var isRegisterValid: Bool {
        !phone.trimmingCharacters(in: .whitespaces).isEmpty &&
        email.contains("@") && email.contains(".") &&
        password.count >= 6 &&
        password == confirmPassword
    }
    
    public var isLoginValid: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty &&
        !password.isEmpty
    }
    
    public func handleLogin(onSuccess: @escaping () -> Void) {
        errorMessage = nil
        guard isLoginValid else {
            errorMessage = "Wprowadź prawidłowy email oraz hasło."
            playErrorFeedback()
            return
        }
        
        isProcessing = true
        
        // Fast optimized response time for quick app entry
        Task {
            try? await Task.sleep(nanoseconds: 350_000_000)
            self.isProcessing = false
            let successFeedback = UINotificationFeedbackGenerator()
            successFeedback.notificationOccurred(.success)
            onSuccess()
        }
    }
    
    public func handleRegister(onSuccess: @escaping () -> Void) {
        errorMessage = nil
        guard isRegisterValid else {
            if password != confirmPassword {
                errorMessage = "Hasła nie są identyczne."
            } else if password.count < 6 {
                errorMessage = "Hasło musi mieć co najmniej 6 znaków."
            } else {
                errorMessage = "Uzupełnij wszystkie wymagane pola rejestracji."
            }
            playErrorFeedback()
            return
        }
        
        isProcessing = true
        
        Task {
            try? await Task.sleep(nanoseconds: 400_000_000)
            self.isProcessing = false
            self.showRegistrationAnimation = true
            
            let impact = UINotificationFeedbackGenerator()
            impact.notificationOccurred(.success)
            
            // Allow animation to complete, then swiftly transition into main app
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            onSuccess()
        }
    }
    
    private func playErrorFeedback() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.error)
    }
}
