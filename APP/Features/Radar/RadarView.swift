import SwiftUI

public struct RadarView: View {
    @State private var isPulsing: Bool = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            Theme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Theme.neonGreen.opacity(0.3), lineWidth: 1)
                        .frame(width: 140, height: 140)
                        .scaleEffect(isPulsing ? 1.2 : 0.8)
                        .opacity(isPulsing ? 0.0 : 0.8)
                    
                    Circle()
                        .fill(Theme.neonGreen.opacity(0.1))
                        .frame(width: 90, height: 90)
                    
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Theme.neonGreen)
                }
                .overlay(
                    Circle()
                        .stroke(Theme.neonGreen.opacity(0.4), lineWidth: 1)
                )
                
                VStack(spacing: 8) {
                    Text("MARKET RADAR")
                        .font(Typography.ticker(18))
                        .fontWeight(.bold)
                        .foregroundColor(Theme.textPrimary)
                    
                    Text("Skaner rynkowy w czasie rzeczywistym. Sygnały breakout i wolumeny.")
                        .font(Typography.caption(13))
                        .foregroundColor(Theme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                
                Spacer()
            }
            .padding(.bottom, 80)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                isPulsing = true
            }
        }
    }
}
