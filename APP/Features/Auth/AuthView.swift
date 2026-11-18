import SwiftUI

public struct AuthView: View {
    @Bindable var viewModel: AuthViewModel
    let onAuthSuccess: () -> Void
    
    @Namespace private var modeAnimationNamespace
    @State private var logoRotating: Bool = false
    @State private var laserScanOffset: CGFloat = -20
    @State private var isFaceIDScanning: Bool = false
    
    public init(viewModel: AuthViewModel, onAuthSuccess: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onAuthSuccess = onAuthSuccess
    }
    
    public var body: some View {
        ZStack {
            AmbientBackground()
            
            if viewModel.showRegistrationAnimation {
                RegistrationSuccessView()
                    .transition(.opacity.combined(with: .scale(scale: 0.94)))
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 22) {
                        hologramLogoSection
                        slidingModeSelectorSection
                        inputFieldsSection
                        
                        if viewModel.mode == .register && !viewModel.password.isEmpty {
                            passwordStrengthSection
                        }
                        
                        if let error = viewModel.errorMessage {
                            errorMessageView(error)
                        }
                        
                        submitButtonSection
                        
                        if viewModel.mode == .login {
                            biometricsSection
                        }
                        
                        footerSection
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 36)
                    .padding(.bottom, 40)
                }
                .transition(.opacity)
            }
        }
    }
    
    private var hologramLogoSection: some View {
        VStack(spacing: 14) {
            ZStack {
                // Outer slow rotating cyber ring
                Circle()
                    .stroke(
                        AngularGradient(
                            colors: [Theme.neonGreen, Color.cyan, Color.clear, Theme.neonGreen],
                            center: .center
                        ),
                        lineWidth: 2
                    )
                    .frame(width: 84, height: 84)
                    .rotationEffect(.degrees(logoRotating ? 360 : 0))
                    .shadow(color: Theme.neonGreen.opacity(0.4), radius: 12)
                
                // Translucent core disk
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 72, height: 72)
                    .overlay(
                        Circle().stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 30, weight: .black))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.white, Theme.neonGreen],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            .onAppear {
                withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: false)) {
                    logoRotating = true
                }
            }
            
            VStack(spacing: 4) {
                Text("TRADING DESK")
                    .font(Typography.ticker(24))
                    .fontWeight(.heavy)
                    .foregroundColor(Theme.textPrimary)
                    .tracking(2.5)
                
                HStack(spacing: 6) {
                    Circle()
                        .fill(Theme.neonGreen)
                        .frame(width: 6, height: 6)
                        .shadow(color: Theme.neonGreen, radius: 4)
                    
                    Text("PRO HIGH-FREQUENCY TERMINAL")
                        .font(Typography.caption(10))
                        .fontWeight(.bold)
                        .foregroundColor(Theme.neonGreen)
                        .tracking(1.2)
                }
            }
        }
        .padding(.bottom, 6)
    }
    
    private var slidingModeSelectorSection: some View {
        HStack(spacing: 0) {
            ForEach(AuthMode.allCases) { mode in
                let isSelected = viewModel.mode == mode
                Button(action: { selectMode(mode) }) {
                    ZStack {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    LinearGradient(
                                        colors: [Theme.neonGreen, Theme.neonMint],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .matchedGeometryEffect(id: "authModePill", in: modeAnimationNamespace)
                                .shadow(color: Theme.neonGreen.opacity(0.35), radius: 8, x: 0, y: 3)
                        }
                        
                        Text(mode.rawValue)
                            .font(Typography.body(14, weight: isSelected ? .bold : .medium))
                            .foregroundColor(isSelected ? .black : Theme.textSecondary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.08, green: 0.09, blue: 0.12).opacity(0.8))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
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
                        Image(systemName: viewModel.isPasswordMatching ? "checkmark.seal.fill" : "xmark.octagon.fill")
                            .foregroundColor(viewModel.isPasswordMatching ? Theme.neonGreen : Theme.errorRed)
                        Text(viewModel.isPasswordMatching ? "Hasła są w 100% zgodne" : "Hasła nie pasują do siebie")
                            .font(Typography.caption(12, weight: .semibold))
                            .foregroundColor(viewModel.isPasswordMatching ? Theme.neonGreen : Theme.errorRed)
                        Spacer()
                    }
                    .padding(.horizontal, 4)
                }
            } else {
                CyberTextField(
                    "E-mail lub login",
                    icon: "person.crop.circle.fill",
                    text: $viewModel.email,
                    keyboardType: .emailAddress
                )
                
                CyberTextField(
                    "Hasło dostępu",
                    icon: "lock.fill",
                    text: $viewModel.password,
                    isSecure: true
                )
            }
        }
    }
    
    private var passwordStrengthSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                ForEach(0..<4) { index in
                    RoundedRectangle(cornerRadius: 3)
                        .fill(passwordBarColor(for: index))
                        .frame(height: 4)
                }
            }
            
            Text(passwordStrengthLabel)
                .font(Typography.caption(11, weight: .semibold))
                .foregroundColor(passwordStrengthColor)
        }
        .padding(.horizontal, 4)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: viewModel.password)
    }
    
    private var passwordStrengthLevel: Int {
        let count = viewModel.password.count
        if count == 0 { return 0 }
        if count < 6 { return 1 }
        if count < 9 { return 2 }
        if count < 12 { return 3 }
        return 4
    }
    
    private func passwordBarColor(for index: Int) -> Color {
        let level = passwordStrengthLevel
        if index >= level {
            return Color.white.opacity(0.08)
        }
        switch level {
        case 1: return Theme.errorRed
        case 2: return Color.orange
        case 3: return Color.yellow
        default: return Theme.neonGreen
        }
    }
    
    private var passwordStrengthLabel: String {
        switch passwordStrengthLevel {
        case 0: return ""
        case 1: return "Siła hasła: Za krótkie"
        case 2: return "Siła hasła: Średnie"
        case 3: return "Siła hasła: Silne"
        default: return "Siła hasła: Pancerne (Maksymalne)"
        }
    }
    
    private var passwordStrengthColor: Color {
        switch passwordStrengthLevel {
        case 1: return Theme.errorRed
        case 2: return Color.orange
        case 3: return Color.yellow
        default: return Theme.neonGreen
        }
    }
    
    private func errorMessageView(_ message: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(Theme.errorRed)
            Text(message)
                .font(Typography.caption(12, weight: .medium))
                .foregroundColor(Theme.errorRed)
            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Theme.errorRed.opacity(0.12))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Theme.errorRed.opacity(0.3), lineWidth: 1)
        )
    }
    
    private var submitButtonSection: some View {
        NeonButton(
            viewModel.mode == .login ? "ZALOGUJ DO TERMINALA" : "ZAREJESTRUJ I URUCHOM",
            icon: viewModel.mode == .login ? "arrow.right.circle.fill" : "bolt.shield.fill",
            isLoading: viewModel.isProcessing,
            action: submit
        )
        .padding(.top, 4)
    }
    
    private var biometricsSection: some View {
        Button(action: triggerFaceIDScan) {
            HStack(spacing: 10) {
                ZStack {
                    Image(systemName: "faceid")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Theme.neonGreen)
                    
                    if isFaceIDScanning {
                        Rectangle()
                            .fill(Theme.neonGreen)
                            .frame(width: 24, height: 2)
                            .offset(y: laserScanOffset)
                    }
                }
                
                Text(isFaceIDScanning ? "Weryfikacja biometryczna..." : "Zaloguj przez Face ID")
                    .font(Typography.body(13, weight: .semibold))
                    .foregroundColor(Theme.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white.opacity(0.04))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isFaceIDScanning ? Theme.neonGreen.opacity(0.6) : Theme.cardBorder, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
    
    private var footerSection: some View {
        VStack(spacing: 8) {
            Text("Szyfrowanie End-to-End • Klucze lokalne")
                .font(Typography.caption(11))
                .foregroundColor(Theme.textTertiary)
        }
    }
    
    private func selectMode(_ mode: AuthMode) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
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
    
    private func triggerFaceIDScan() {
        guard !isFaceIDScanning else { return }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        isFaceIDScanning = true
        withAnimation(.easeInOut(duration: 0.5).repeatCount(2, autoreverses: true)) {
            laserScanOffset = 20
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.isFaceIDScanning = false
            self.laserScanOffset = -20
            self.viewModel.email = "demo@tradingdesk.io"
            self.viewModel.password = "securepass123"
            self.viewModel.handleLogin(onSuccess: self.onAuthSuccess)
        }
    }
}
