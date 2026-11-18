import SwiftUI

public struct HomeView: View {
    @Bindable var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            Theme.backgroundDark.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    topLiveDeskSection
                    balanceSection
                    waveChartSection
                    filtersSection
                    activityHeaderSection
                    tradesListSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 100) // Padding for custom bottom tab bar
            }
        }
    }
    
    private var topLiveDeskSection: some View {
        HStack {
            GlowingLiveBadge("LIVE DESK")
            Spacer()
        }
    }
    
    private var balanceSection: some View {
        HStack(alignment: .center, spacing: 14) {
            Text(viewModel.balance)
                .font(.system(size: 40, weight: .black, design: .rounded))
                .foregroundColor(Theme.textPrimary)
            
            ProfitBadge(
                amount: viewModel.deltaAmount,
                percentage: viewModel.deltaPercentage,
                isPositive: true
            )
            
            MultiplierBadge(viewModel.multiplier)
            
            Spacer()
        }
    }
    
    private var waveChartSection: some View {
        LiveOscilloscopeChart(height: 70)
            .padding(.vertical, 4)
    }
    
    private var filtersSection: some View {
        HStack(spacing: 8) {
            ForEach(TimeframeFilter.allCases) { filter in
                let isSelected = viewModel.selectedFilter == filter
                Button(action: { viewModel.selectFilter(filter) }) {
                    Text(filter.displayTitle)
                        .font(Typography.ticker(12))
                        .fontWeight(isSelected ? .bold : .medium)
                        .foregroundColor(isSelected ? .black : Theme.textSecondary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(isSelected ? Theme.neonGreen : Color.white.opacity(0.06))
                        )
                        .overlay(
                            Capsule()
                                .stroke(isSelected ? Theme.neonGreen : Theme.cardBorder, lineWidth: 0.8)
                        )
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var activityHeaderSection: some View {
        HStack {
            Text("Activity")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Theme.textPrimary)
            
            Spacer()
            
            Button("See all") {
                // Future expansion
            }
            .font(Typography.body(14, weight: .semibold))
            .foregroundColor(Theme.neonGreen)
        }
        .padding(.top, 8)
    }
    
    private var tradesListSection: some View {
        LazyVStack(spacing: 12) {
            ForEach(viewModel.trades) { trade in
                ActivityRowView(trade: trade)
            }
        }
    }
}
