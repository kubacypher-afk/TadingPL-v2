import SwiftUI
import UIKit

public struct ActivityRowView: View {
    public let trade: CryptoTrade
    @State private var isPressed: Bool = false
    @State private var isLivePulsing: Bool = false
    
    public init(trade: CryptoTrade) {
        self.trade = trade
    }
    
    public var body: some View {
        Button(action: handleTap) {
            HStack(spacing: 14) {
                avatarView
                infoView
                Spacer(minLength: 8)
                profitPillView
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.10, green: 0.12, blue: 0.16).opacity(0.9),
                                Color(red: 0.07, green: 0.08, blue: 0.11).opacity(0.95)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.18),
                                Color.white.opacity(0.04),
                                trade.avatarColor.opacity(0.15)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 5)
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
        }
        .buttonStyle(RowPressableStyle(isPressedBinding: $isPressed))
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                isLivePulsing = true
            }
        }
    }
    
    private var avatarView: some View {
        ZStack {
            Circle()
                .fill(trade.avatarColor.opacity(0.22))
                .frame(width: 46, height: 46)
            
            Circle()
                .stroke(trade.avatarColor.opacity(0.5), lineWidth: 1.2)
                .frame(width: 46, height: 46)
                .shadow(color: trade.avatarColor.opacity(0.3), radius: 8)
            
            Text(trade.avatarLetter)
                .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(trade.avatarColor)
        }
    }
    
    private var infoView: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 6) {
                Text(trade.pair)
                    .font(Typography.ticker(15))
                    .fontWeight(.bold)
                    .foregroundColor(Theme.textPrimary)
                
                Text("•")
                    .foregroundColor(Theme.textTertiary)
                
                Text(trade.strategy)
                    .font(Typography.caption(13))
                    .foregroundColor(Theme.textSecondary)
            }
            
            HStack(spacing: 6) {
                Text(trade.timeAgo)
                    .font(Typography.caption(12))
                    .foregroundColor(Theme.textTertiary)
                
                Text("•")
                    .foregroundColor(Theme.textTertiary)
                
                Circle()
                    .fill(Theme.neonGreen)
                    .frame(width: 5, height: 5)
                    .shadow(color: Theme.neonGreen, radius: isLivePulsing ? 4 : 1)
                
                Text(trade.status)
                    .font(Typography.caption(12, weight: .semibold))
                    .foregroundColor(Theme.neonGreen)
            }
        }
    }
    
    private var profitPillView: some View {
        VStack(alignment: .trailing, spacing: 3) {
            Text(trade.profitAmount)
                .font(Typography.ticker(15))
                .fontWeight(.heavy)
                .foregroundColor(trade.isPositive ? Theme.neonGreen : Theme.errorRed)
            
            Text(trade.profitPercentage)
                .font(Typography.ticker(11))
                .foregroundColor(trade.isPositive ? Theme.neonGreen.opacity(0.85) : Theme.errorRed.opacity(0.85))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill((trade.isPositive ? Theme.neonGreen : Theme.errorRed).opacity(0.12))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    (trade.isPositive ? Theme.neonGreen : Theme.errorRed).opacity(0.35),
                    lineWidth: 1
                )
        )
    }
    
    private func handleTap() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

public struct RowPressableStyle: ButtonStyle {
    @Binding var isPressedBinding: Bool
    
    public init(isPressedBinding: Binding<Bool>) {
        self._isPressedBinding = isPressedBinding
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, newValue in
                isPressedBinding = newValue
            }
    }
}
