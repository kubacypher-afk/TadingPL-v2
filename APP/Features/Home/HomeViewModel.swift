import SwiftUI
import Observation
import UIKit

@Observable
@MainActor
public final class HomeViewModel {
    public var balance: String = "$10.00"
    public var deltaAmount: String = "+$0.00"
    public var deltaPercentage: String = "0.00%"
    public var multiplier: String = "1.00x"
    public var selectedFilter: TimeframeFilter = .live
    public var trades: [CryptoTrade] = []
    
    public init() {
        loadInitialTrades()
    }
    
    public func selectFilter(_ filter: TimeframeFilter) {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
            selectedFilter = filter
        }
    }
    
    private func loadInitialTrades() {
        trades = [
            CryptoTrade(
                pair: "SOL / USDT",
                strategy: "Long Scalp",
                status: "Take Profit 100%",
                timeAgo: "2m ago",
                profitAmount: "+$42.80",
                profitPercentage: "+14.2%",
                isPositive: true,
                avatarLetter: "S",
                avatarColor: Theme.solanaPurple
            ),
            CryptoTrade(
                pair: "BTC / USDT",
                strategy: "Breakout",
                status: "Auto Compound Exit",
                timeAgo: "18m ago",
                profitAmount: "+$118.50",
                profitPercentage: "+8.9%",
                isPositive: true,
                avatarLetter: "₿",
                avatarColor: Theme.bitcoinOrange
            ),
            CryptoTrade(
                pair: "ETH / USDT",
                strategy: "Momentum",
                status: "Active Scalp",
                timeAgo: "32m ago",
                profitAmount: "+$27.40",
                profitPercentage: "+5.1%",
                isPositive: true,
                avatarLetter: "Ξ",
                avatarColor: Theme.ethereumBlue
            ),
            CryptoTrade(
                pair: "PEPE / USDT",
                strategy: "Pump Hunter",
                status: "Trailing Stop 85%",
                timeAgo: "1h ago",
                profitAmount: "+$384.10",
                profitPercentage: "+45.6%",
                isPositive: true,
                avatarLetter: "P",
                avatarColor: Theme.pepeGreen
            )
        ]
    }
}
