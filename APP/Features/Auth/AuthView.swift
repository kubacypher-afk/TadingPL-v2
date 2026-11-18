import SwiftUI

public struct AuthView: View {
    @Bindable var viewModel: AuthViewModel
    let onAuthSuccess: () -> Void
    
    public init(viewModel: AuthViewModel, onAuthSuccess: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onAuthSuccess = onAuthSuccess
    }
    
    public var body: some View {
        ZStack {
            Theme.backgroundDark.ignoresSafeArea()
            
            if viewModel.showRegistrationAnimation {
                RegistrationSuccessView()
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        headerSection
                        modeSelectorSection
                        inputFieldsSection
                        
                        if let error = viewModel.errorMessage {
                            errorMessageView(error)
                        }
                        
                        submitButtonSection
                        footerSection
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)
                    .padding(.bottom, 32)
                }
                .transition(.opacity)
            }
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Theme.neonGreen.opacity(0.12))
                    .frame(width: 68, height: 68)
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Theme.neonGreen)
            }
            .overlay(
                Circle()
                    .stroke(Theme.neonGreen.opacity(0.4), lineWidth: 1)
            )
            .shadow(color: Theme.neonGlow, radius: 10)
            
            Text("TRADING DESK")
                .font(Typography.ticker(22))
                .fontWeight(.heavy)
                .foregroundColor(Theme.textPrimary)
                .tracking(2.0)
            
            Text("Zaawansowana platforma tradingu i analizy")
                .font(Typography.caption(13))
                .foregroundColor(Theme.textSecondary)
        }
        .padding(.bottom, 8)
    }
    
    private var modeSelectorSection: some View {
        HStack(spacing: 0) {
            ForEach(AuthMode.allCases) { mode in
                let isSelected = viewModel.mode == mode
                Button(action: { selectMode(mode) }) {
                    Text(mode.rawValue)
                        .font(Typography.body(14, weight: isSelected ? .bold : .medium))
                        .foregroundColor(isSelected ? .black : Theme.textSecondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 42)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(isSelected ? Theme.neonGreen : Color.clear)
                        )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Theme.cardBorder, lineWidth: 1)
        )
    }
    
    private var inputFieldsSection: some View {
        VStack(spacing: 14) {
            if viewModel.mode == .register {
                CyberTextField(
                    "Numer telefonu (+48 ...)",
                    icon: "phone.fill",
                    text: $viewModel.phone,
                    keyboardType: .phonePad
                )
                
                CyberTextField(
                    "Adres e-mail",
                    icon: "envelope.fill",
                    text: $viewModel.email,
                    keyboardType: .emailAddress
                )
                
                CyberTextField(
                    "Hasło (min. 6 znaków)",
                    icon: "lock.fill",
                    text: $viewModel.password,
                    isSecure: true
                )
                
                CyberTextField(
                    "Powtórz hasło",
                    icon: "lock.shield.fill",
                    text: $viewModel.confirmPassword,
                    isSecure: true
                )
                
                if !viewModel.password.isEmpty && !viewModel.confirmPassword.isEmpty {
                    HStack(spacing: 6) {
                        Image(systemName: viewModel.isPasswordMatching ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(viewModel.isPasswordMatching ? Theme.neonGreen : Theme.errorRed)
                        Text(viewModel.isPasswordMatching ? "Hasła są identyczne" : "Hasła się różnią")
                            .font(Typography.caption(12))
                            .foregroundColor(viewModel.isPasswordMatching ? Theme.neonGreen : Theme.errorRed)
                        Spacer()
                    }
                    .padding(.horizontal, 4)
                }
            } else {
                CyberTextField(
                    "E-mail lub login",
                    icon: "person.fill",
                    text: $viewModel.email,
                    keyboardType: .emailAddress
                )
                
                CyberTextField(
                    "Hasło",
                    icon: "lock.fill",
                    text: $viewModel.password,
                    isSecure: true
                )
            }
        }
    }
    
    private func errorMessageView(_ message: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(Theme.errorRed)
            Text(message)
                .font(Typography.caption(12))
                .foregroundColor(Theme.errorRed)
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Theme.errorRed.opacity(0.12))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.errorRed.opacity(0.3), lineWidth: 1)
        )
    }
    
    private var submitButtonSection: some View {
        NeonButton(
            viewModel.mode == .login ? "ZALOGUJ SIĘ" : "ZAREJESTRUJ KONTO",
            icon: viewModel.mode == .login ? "arrow.right.circle.fill" : "person.badge.plus.fill",
            isLoading: viewModel.isProcessing,
            action: submit
        )
        .padding(.top, 6)
    }
    
    private var footerSection: some View {
        VStack(spacing: 12) {
            Text("Zabezpieczone szyfrowaniem AES-256 GCM")
                .font(Typography.caption(11))
                .foregroundColor(Theme.textTertiary)
        }
    }
    
    private func selectMode(_ mode: AuthMode) {
        withAnimation(.spring(response: 0.25, dampingFraction: 0.75)) {
            viewModel.mode = mode
            viewModel.errorMessage = nil
        }
    }
    
    private func submit() {
        if viewModel.mode == .login {
            viewModel.handleLogin(onSuccess: onAuthSuccess)
        } else {
            viewModel.handleRegister(onSuccess: onAuthSuccess)
        }
    }
}
