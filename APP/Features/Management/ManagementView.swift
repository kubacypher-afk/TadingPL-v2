import SwiftUI

public struct ManagementView: View {
    @State private var botScalpActive: Bool = true
    @State private var botBreakoutActive: Bool = true
    @State private var botWhaleActive: Bool = false
    @State private var riskLevel: Double = 2.5
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AmbientBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    HStack {
                        GlowingLiveBadge("ALGO MANAGEMENT")
                        Spacer()
                        Text("Silnik v4.2")
                            .font(Typography.ticker(11))
                            .foregroundColor(Theme.neonGreen)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    
                    // Risk allocation card
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("MAKSYMALNE RYZYKO NA TRADE")
                                .font(Typography.ticker(12))
                                .foregroundColor(Theme.textSecondary)
                            Spacer()
                            Text(String(format: "%.1f%%", riskLevel))
                                .font(Typography.ticker(16))
                                .fontWeight(.bold)
                                .foregroundColor(Theme.neonGreen)
                        }
                        
                        Slider(value: $riskLevel, in: 0.5...10.0, step: 0.5)
                            .tint(Theme.neonGreen)
                    }
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color(red: 0.08, green: 0.10, blue: 0.14).opacity(0.85))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    
                    // Bot Controllers
                    VStack(alignment: .leading, spacing: 12) {
                        Text("AKTYWNE ALGORYTMY TRADINGOWE")
                            .font(Typography.ticker(13))
                            .fontWeight(.bold)
                            .foregroundColor(Theme.textSecondary)
                            .padding(.horizontal, 20)
                        
                        botRow(
                            name: "SOL Ultra-Fast Scalper",
                            strategy: "Sub-second orderbook latency",
                            profit: "+$324.80",
                            isOn: $botScalpActive
                        )
                        
                        botRow(
                            name: "BTC Multi-Timeframe Breakout",
                            strategy: "EMA 200 + Volume Surge Filter",
                            profit: "+$892.10",
                            isOn: $botBreakoutActive
                        )
                        
                        botRow(
                            name: "Whale Wallet Tracker",
                            strategy: "On-chain transaction radar",
                            profit: "+$0.00",
                            isOn: $botWhaleActive
                        )
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 120)
            }
        }
    }
    
    private func botRow(name: String, strategy: String, profit: String, isOn: Binding<Bool>) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(Typography.body(14, weight: .bold))
                    .foregroundColor(Theme.textPrimary)
                Text(strategy)
                    .font(Typography.caption(11))
                    .foregroundColor(Theme.textSecondary)
                Text(profit)
                    .font(Typography.ticker(12))
                    .foregroundColor(Theme.neonGreen)
            }
            
            Spacer()
            
            Toggle("", isOn: isOn)
                .labelsHidden()
                .tint(Theme.neonGreen)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.08, green: 0.10, blue: 0.14).opacity(0.8))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
    }
}
