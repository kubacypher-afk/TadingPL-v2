import SwiftUI

public struct HistoryView: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            Theme.backgroundDark.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Theme.neonGreen.opacity(0.1))
                        .frame(width: 90, height: 90)
                    
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Theme.neonGreen)
                }
                .overlay(
                    Circle()
                        .stroke(Theme.neonGreen.opacity(0.3), lineWidth: 1)
                )
                
                VStack(spacing: 8) {
                    Text("TRADE HISTORY")
                        .font(Typography.ticker(18))
                        .fontWeight(.bold)
                        .foregroundColor(Theme.textPrimary)
                    
                    Text("Pełna historia transakcji, zrealizowany P&L oraz raporty podatkowe.")
                        .font(Typography.caption(13))
                        .foregroundColor(Theme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                
                Spacer()
            }
            .padding(.bottom, 80)
        }
    }
}
