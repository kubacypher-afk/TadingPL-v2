import SwiftUI
import UIKit

public struct HomeView: View {
    @Bindable var viewModel: HomeViewModel
    @Namespace private var filterAnimationNamespace
    @State private var cardsAppeared: Bool = false
    @State private var balanceScale: CGFloat = 1.0
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            AmbientBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    topLiveDeskSection
                    balanceSection
                    waveChartSection
                    filtersSection
                    activityHeaderSection
                    tradesListSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 120) // Safe margin for floating glass tab bar
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                cardsAppeared = true
            }
        }
    }
    
    private var topLiveDeskSection: some View {
        HStack {
            GlowingLiveBadge("LIVE DESK")
            
            Spacer()
            
            // Real-time ping counter
            HStack(spacing: 4) {
                Circle()
                    .fill(Theme.neonGreen)
                    .frame(width: 5, height: 5)
                Text("12ms")
                    .font(Typography.ticker(11))
                    .foregroundColor(Theme.textTertiary)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Capsule().fill(Color.white.opacity(0.04)))
        }
    }
    
    private var balanceSection: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(viewModel.balance)
                .font(.system(size: 42, weight: .black, design: .rounded))
                .foregroundColor(Theme.textPrimary)
                .scaleEffect(balanceScale)
            
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
        LiveOscilloscopeChart(height: 78)
            .padding(.vertical, 2)
    }
    
    private var filtersSection: some View {
        HStack(spacing: 8) {
            ForEach(TimeframeFilter.allCases) { filter in
                let isSelected = viewModel.selectedFilter == filter
                Button(action: { selectFilter(filter) }) {
                    ZStack {
                        if isSelected {
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [Theme.neonGreen, Theme.neonMint],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .matchedGeometryEffect(id: "filterActiveCapsule", in: filterAnimationNamespace)
                                .shadow(color: Theme.neonGreen.opacity(0.35), radius: 8, x: 0, y: 3)
                        }
                        
                        Text(filter.displayTitle)
                            .font(Typography.ticker(12))
                            .fontWeight(isSelected ? .bold : .medium)
                            .foregroundColor(isSelected ? .black : Theme.textSecondary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                    }
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
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            }
            .font(Typography.body(14, weight: .semibold))
            .foregroundColor(Theme.neonGreen)
        }
        .padding(.top, 6)
    }
    
    private var tradesListSection: some View {
        LazyVStack(spacing: 12) {
            ForEach(Array(viewModel.trades.enumerated()), id: \.element.id) { index, trade in
                ActivityRowView(trade: trade)
                    .offset(y: cardsAppeared ? 0 : CGFloat(30 + index * 15))
                    .opacity(cardsAppeared ? 1 : 0)
                    .animation(
                        .spring(response: 0.45, dampingFraction: 0.75).delay(Double(index) * 0.08),
                        value: cardsAppeared
                    )
            }
        }
    }
    
    private func selectFilter(_ filter: TimeframeFilter) {
        viewModel.selectFilter(filter)
        withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) {
            balanceScale = 1.05
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                self.balanceScale = 1.0
            }
        }
    }
}
