import SwiftUI
import Observation
import UIKit
import LocalAuthentication

@Observable
@MainActor
public final class AuthViewModel {
    public var mode: AuthMode = .login
    public var phone: String = ""
    public var email: String = ""
    public var password: String = ""
    public var confirmPassword: String = ""
    
    public var isProcessing: Bool = false
    public var isBiometricEvaluating: Bool = false
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
            
            try? await Task.sleep(nanoseconds: 1_200_000_000)
            onSuccess()
        }
    }
    
    public func authenticateWithBiometrics(onSuccess: @escaping () -> Void) {
        errorMessage = nil
        let context = LAContext()
        context.localizedCancelTitle = "Anuluj"
        var authError: NSError?
        
        let reason = "Potwierdź tożsamość Face ID, aby odblokować terminal Trading Desk."
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            isBiometricEvaluating = true
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluationError in
                Task { @MainActor in
                    self.isBiometricEvaluating = false
                    if success {
                        let feedback = UINotificationFeedbackGenerator()
                        feedback.notificationOccurred(.success)
                        onSuccess()
                    } else if let error = evaluationError as? LAError {
                        self.handleBiometricError(error)
                    }
                }
            }
        } else if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            // Fallback to device passcode/system auth
            isBiometricEvaluating = true
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluationError in
                Task { @MainActor in
                    self.isBiometricEvaluating = false
                    if success {
                        let feedback = UINotificationFeedbackGenerator()
                        feedback.notificationOccurred(.success)
                        onSuccess()
                    } else if let error = evaluationError as? LAError, error.code != .userCancel {
                        self.playErrorFeedback()
                        self.errorMessage = "Weryfikacja biometryczna nie powiodła się."
                    }
                }
            }
        } else {
            playErrorFeedback()
            errorMessage = "Face ID nie jest aktywne na tym urządzeniu lub w symulatorze. Włącz Face ID w ustawieniach."
        }
    }
    
    private func handleBiometricError(_ error: LAError) {
        playErrorFeedback()
        switch error.code {
        case .userCancel, .appCancel:
            break
        case .biometryNotEnrolled:
            errorMessage = "Face ID nie zostało jeszcze skonfigurowane na tym urządzeniu."
        case .biometryLockout:
            errorMessage = "Face ID zablokowane z powodu zbyt wielu prób. Wpisz hasło."
        case .authenticationFailed:
            errorMessage = "Twarz nie została rozpoznana. Spróbuj ponownie."
        default:
            errorMessage = "Błąd Face ID: \(error.localizedDescription)"
        }
    }
    
    private func playErrorFeedback() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.error)
    }
}
