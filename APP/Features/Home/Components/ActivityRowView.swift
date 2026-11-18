import SwiftUI

public struct ActivityRowView: View {
    public let trade: CryptoTrade
    
    public init(trade: CryptoTrade) {
        self.trade = trade
    }
    
    public var body: some View {
        GlassCard(cornerRadius: 18) {
            HStack(spacing: 14) {
                avatarView
                infoView
                Spacer(minLength: 8)
                profitPillView
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
    }
    
    private var avatarView: some View {
        ZStack {
            Circle()
                .fill(trade.avatarColor.opacity(0.2))
                .frame(width: 44, height: 44)
            
            Circle()
                .stroke(trade.avatarColor.opacity(0.4), lineWidth: 1)
                .frame(width: 44, height: 44)
            
            Text(trade.avatarLetter)
                .font(.system(size: 18, weight: .heavy, design: .rounded))
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
                .foregroundColor(trade.isPositive ? Theme.neonGreen.opacity(0.8) : Theme.errorRed.opacity(0.8))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill((trade.isPositive ? Theme.neonGreen : Theme.errorRed).opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke((trade.isPositive ? Theme.neonGreen : Theme.errorRed).opacity(0.25), lineWidth: 0.8)
        )
    }
}
