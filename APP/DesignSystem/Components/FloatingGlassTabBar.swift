import SwiftUI
import UIKit

public struct FloatingGlassTabBar: View {
    @Binding private var selectedTab: TabItem
    @Namespace private var tabAnimationNamespace
    
    public init(selectedTab: Binding<TabItem>) {
        self._selectedTab = selectedTab
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases) { tab in
                tabButton(for: tab)
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 6)
        .frame(height: 54)
        .background(
            // Dark Frosted Glass Background
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.14, green: 0.16, blue: 0.20).opacity(0.95),
                            Color(red: 0.09, green: 0.10, blue: 0.13).opacity(0.98)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        )
        .overlay(
            // Crisp Specular Glass Rim Highlight (1px)
            Capsule()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.35),
                            Color.white.opacity(0.15),
                            Color.white.opacity(0.05)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 1
                )
        )
        .shadow(color: Color.black.opacity(0.6), radius: 16, x: 0, y: 8)
        .shadow(color: Theme.neonGreen.opacity(0.08), radius: 10, x: 0, y: 4)
    }
    
    private func tabButton(for tab: TabItem) -> some View {
        let isSelected = selectedTab == tab
        
        return Button(action: { select(tab) }) {
            ZStack {
                // Sliding Active Glass Pill Capsule (matching reference image)
                if isSelected {
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.22),
                                    Color.white.opacity(0.10)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.3), lineWidth: 0.8)
                        )
                        .matchedGeometryEffect(id: "activeTabCapsule", in: tabAnimationNamespace)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 4)
                }
                
                // Icon View
                if tab == .radar {
                    // Center RADAR Icon (Radar scanner pulse)
                    ZStack {
                        Circle()
                            .stroke(isSelected ? Theme.neonGreen : Color.white.opacity(0.3), lineWidth: 1.2)
                            .frame(width: 26, height: 26)
                        
                        Image(systemName: "dot.radiowaves.left.and.right")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(isSelected ? Theme.neonGreen : Color.white.opacity(0.85))
                    }
                    .scaleEffect(isSelected ? 1.08 : 1.0)
                } else {
                    Image(systemName: tab.iconName)
                        .font(.system(size: 19, weight: isSelected ? .bold : .medium))
                        .foregroundColor(isSelected ? .white : Color(white: 0.6))
                        .scaleEffect(isSelected ? 1.05 : 1.0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    private func select(_ tab: TabItem) {
        if selectedTab != tab {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            withAnimation(.spring(response: 0.32, dampingFraction: 0.76)) {
                selectedTab = tab
            }
        }
    }
}
