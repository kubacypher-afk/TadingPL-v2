import SwiftUI
import UIKit

public struct CyberTabBar: View {
    @Binding private var selectedTab: TabItem
    
    public init(selectedTab: Binding<TabItem>) {
        self._selectedTab = selectedTab
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases) { tab in
                tabButton(for: tab)
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 10)
        .padding(.bottom, 24)
        .background(
            Color(red: 0.05, green: 0.06, blue: 0.08)
                .ignoresSafeArea(edges: .bottom)
        )
        .overlay(
            Rectangle()
                .fill(Theme.cardBorder.opacity(0.8))
                .frame(height: 1),
            alignment: .top
        )
    }
    
    private func tabButton(for tab: TabItem) -> some View {
        let isSelected = selectedTab == tab
        
        return Button(action: { select(tab) }) {
            VStack(spacing: 4) {
                Image(systemName: tab.iconName)
                    .font(.system(size: 20, weight: isSelected ? .bold : .regular))
                    .foregroundColor(isSelected ? Theme.neonGreen : Theme.textTertiary)
                    .frame(height: 24)
                
                Text(tab.rawValue)
                    .font(Typography.caption(10, weight: isSelected ? .bold : .medium))
                    .foregroundColor(isSelected ? Theme.neonGreen : Theme.textTertiary)
                
                Circle()
                    .fill(isSelected ? Theme.neonGreen : Color.clear)
                    .frame(width: 4, height: 4)
                    .shadow(color: Theme.neonGreen, radius: isSelected ? 4 : 0)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    private func select(_ tab: TabItem) {
        if selectedTab != tab {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                selectedTab = tab
            }
        }
    }
}
