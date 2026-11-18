import SwiftUI

public struct GlowingLiveBadge: View {
    private let title: String
    @State private var isPulsing: Bool = false
    
    public init(_ title: String = "LIVE DESK") {
        self.title = title
    }
    
    public var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(Theme.neonGreen)
                .frame(width: 7, height: 7)
                .shadow(color: Theme.neonGreen, radius: isPulsing ? 6 : 2)
                .scaleEffect(isPulsing ? 1.15 : 0.95)
            
            Text(title)
                .font(Typography.ticker(11))
                .foregroundColor(Theme.neonGreen)
                .tracking(0.8)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(Theme.neonGreen.opacity(0.12))
        )
        .overlay(
            Capsule()
                .stroke(Theme.neonGreen.opacity(0.3), lineWidth: 0.8)
        )
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                isPulsing = true
            }
        }
    }
}

public struct ProfitBadge: View {
    private let amount: String
    private let percentage: String
    private let isPositive: Bool
    
    public init(amount: String, percentage: String, isPositive: Bool = true) {
        self.amount = amount
        self.percentage = percentage
        self.isPositive = isPositive
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                .font(.system(size: 11, weight: .bold))
            
            Text("\(amount) (\(percentage))")
                .font(Typography.ticker(12))
                .fontWeight(.bold)
        }
        .foregroundColor(isPositive ? Theme.neonGreen : Theme.errorRed)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill((isPositive ? Theme.neonGreen : Theme.errorRed).opacity(0.12))
        )
        .overlay(
            Capsule()
                .stroke((isPositive ? Theme.neonGreen : Theme.errorRed).opacity(0.3), lineWidth: 0.8)
        )
    }
}

public struct MultiplierBadge: View {
    private let text: String
    
    public init(_ text: String = "1.00x") {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(Typography.ticker(12))
            .foregroundColor(Theme.textSecondary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.06))
            )
            .overlay(
                Capsule()
                    .stroke(Theme.cardBorder, lineWidth: 0.8)
            )
    }
}
