import SwiftUI

public struct RegistrationSuccessView: View {
    @State private var circleScale: CGFloat = 0.2
    @State private var ringScale: CGFloat = 0.5
    @State private var ringOpacity: Double = 0.9
    @State private var checkmarkScale: CGFloat = 0.0
    @State private var textOpacity: Double = 0.0
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Theme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 28) {
                ZStack {
                    // Outer Pulsing Cyber Ring
                    Circle()
                        .stroke(Theme.neonGreen.opacity(ringOpacity), lineWidth: 2)
                        .frame(width: 130, height: 130)
                        .scaleEffect(ringScale)
                    
                    // Core Glow Circle
                    Circle()
                        .fill(Theme.neonGreen.opacity(0.18))
                        .frame(width: 100, height: 100)
                        .scaleEffect(circleScale)
                    
                    Circle()
                        .stroke(Theme.neonGreen, lineWidth: 2.5)
                        .frame(width: 100, height: 100)
                        .scaleEffect(circleScale)
                        .shadow(color: Theme.neonGlow, radius: 16)
                    
                    // Animated Checkmark
                    Image(systemName: "checkmark")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(Theme.neonGreen)
                        .scaleEffect(checkmarkScale)
                }
                
                VStack(spacing: 8) {
                    Text("REJESTRACJA UDANA")
                        .font(Typography.ticker(18))
                        .fontWeight(.bold)
                        .foregroundColor(Theme.textPrimary)
                    
                    Text("Konto aktywowane. Przenoszenie do Live Desk...")
                        .font(Typography.caption(13))
                        .foregroundColor(Theme.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .opacity(textOpacity)
            }
        }
        .onAppear(perform: startSequence)
    }
    
    private func startSequence() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.6)) {
            circleScale = 1.0
        }
        
        withAnimation(.easeOut(duration: 0.9)) {
            ringScale = 1.5
            ringOpacity = 0.0
        }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.5).delay(0.2)) {
            checkmarkScale = 1.0
        }
        
        withAnimation(.easeIn(duration: 0.3).delay(0.35)) {
            textOpacity = 1.0
        }
    }
}
