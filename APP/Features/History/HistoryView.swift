import SwiftUI

public struct HistoryView: View {
    private let historyItems = [
        ("SOL / USDT", "Long Scalp", "+$42.80", "18:42", true),
        ("BTC / USDT", "Breakout", "+$118.50", "17:15", true),
        ("ETH / USDT", "Momentum", "+$27.40", "15:30", true),
        ("ARB / USDT", "Mean Reversion", "-$12.30", "14:02", false),
        ("PEPE / USDT", "Pump Hunter", "+$384.10", "11:18", true)
    ]
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AmbientBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        GlowingLiveBadge("TRADE HISTORY")
                        Spacer()
                        Text("Zrealizowany P&L: +$560.50")
                            .font(Typography.ticker(12))
                            .fontWeight(.bold)
                            .foregroundColor(Theme.neonGreen)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    
                    VStack(spacing: 10) {
                        ForEach(historyItems, id: \.0) { item in
                            HStack {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(item.0)
                                        .font(Typography.ticker(14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Theme.textPrimary)
                                    Text(item.1)
                                        .font(Typography.caption(11))
                                        .foregroundColor(Theme.textSecondary)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 3) {
                                    Text(item.2)
                                        .font(Typography.ticker(14))
                                        .fontWeight(.bold)
                                        .foregroundColor(item.4 ? Theme.neonGreen : Theme.errorRed)
                                    Text(item.3)
                                        .font(Typography.caption(11))
                                        .foregroundColor(Theme.textTertiary)
                                }
                            }
                            .padding(14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color(red: 0.08, green: 0.10, blue: 0.14).opacity(0.8))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.white.opacity(0.06), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 120)
            }
        }
    }
}
