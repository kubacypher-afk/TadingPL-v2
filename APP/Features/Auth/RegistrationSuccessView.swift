import SwiftUI
import UIKit

public struct RegistrationSuccessView: View {
    @State private var circleScale: CGFloat = 0.2
    @State private var ringScale: CGFloat = 0.5
    @State private var ringOpacity: Double = 0.9
    @State private var checkmarkScale: CGFloat = 0.0
    @State private var statusStepIndex: Int = 0
    @State private var hexagonRotation: Double = 0
    
    private let statusMessages = [
        "Inicjalizacja węzła P2P...",
        "Generowanie kluczy kryptograficznych...",
        "Szyfrowanie tożsamości portfela...",
        "Konto aktywowane! Przenoszenie..."
    ]
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AmbientBackground()
            
            VStack(spacing: 32) {
                ZStack {
                    // Outer pulsating hexagon aura
                    Image(systemName: "hexagon")
                        .font(.system(size: 140, weight: .ultraLight))
                        .foregroundColor(Theme.neonGreen.opacity(0.35))
                        .rotationEffect(.degrees(hexagonRotation))
                    
                    // Shockwave circle
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
                        .stroke(
                            LinearGradient(
                                colors: [Color.white, Theme.neonGreen],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 3
                        )
                        .frame(width: 100, height: 100)
                        .scaleEffect(circleScale)
                        .shadow(color: Theme.neonGlow, radius: 20)
                    
                    // Animated Checkmark
                    Image(systemName: "checkmark")
                        .font(.system(size: 46, weight: .black))
                        .foregroundColor(Theme.neonGreen)
                        .scaleEffect(checkmarkScale)
                }
                
                VStack(spacing: 10) {
                    Text("REJESTRACJA ZAKOŃCZONA")
                        .font(Typography.ticker(20))
                        .fontWeight(.heavy)
                        .foregroundColor(Theme.textPrimary)
                        .tracking(1.5)
                    
                    Text(statusMessages[statusStepIndex])
                        .font(Typography.caption(13, weight: .medium))
                        .foregroundColor(Theme.neonGreen)
                        .multilineTextAlignment(.center)
                        .id(statusStepIndex)
                        .transition(.asymmetric(
                            insertion: .offset(y: 8).combined(with: .opacity),
                            removal: .offset(y: -8).combined(with: .opacity)
                        ))
                }
            }
        }
        .onAppear(perform: startSequence)
    }
    
    private func startSequence() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
            circleScale = 1.0
        }
        
        withAnimation(.easeOut(duration: 1.1)) {
            ringScale = 1.6
            ringOpacity = 0.0
        }
        
        withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: false)) {
            hexagonRotation = 360
        }
        
        withAnimation(.spring(response: 0.45, dampingFraction: 0.5).delay(0.25)) {
            checkmarkScale = 1.0
        }
        
        // Progressively advance through stages
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if statusStepIndex < statusMessages.count - 1 {
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                withAnimation(.easeInOut(duration: 0.2)) {
                    statusStepIndex += 1
                }
            } else {
                timer.invalidate()
            }
        }
    }
}
