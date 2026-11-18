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
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(
            // Frosted Glass Material + Cyber Dark Tint
            ZStack {
                Capsule()
                    .fill(.ultraThinMaterial)
                
                Capsule()
                    .fill(Color(red: 0.12, green: 0.13, blue: 0.16).opacity(0.85))
            }
        )
        .overlay(
            // Specular Glass Rim Lighting
            Capsule()
                .stroke(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.35),
                            Color.white.opacity(0.1),
                            Theme.neonGreen.opacity(0.2),
                            Color.white.opacity(0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.2
                )
        )
        .shadow(color: Color.black.opacity(0.55), radius: 24, x: 0, y: 12)
        .shadow(color: Theme.neonGreen.opacity(0.12), radius: 18, x: 0, y: 6)
        .padding(.horizontal, 24)
        .padding(.bottom, 12)
    }
    
    private func tabButton(for tab: TabItem) -> some View {
        let isSelected = selectedTab == tab
        
        return Button(action: { select(tab) }) {
            ZStack {
                // Sliding Active Pill Capsule (matching screenshot)
                if isSelected {
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.18),
                                    Color.white.opacity(0.08)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.25), lineWidth: 0.8)
                        )
                        .matchedGeometryEffect(id: "activeTabCapsule", in: tabAnimationNamespace)
                        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 3)
                }
                
                // Content Icon & Badge
                HStack(spacing: 4) {
                    if tab == .radar {
                        // Center highlighted action style (like screenshot's center button)
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .frame(width: 38, height: 26)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            LinearGradient(
                                                colors: [Color.cyan, Color.pink],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            ),
                                            lineWidth: 2
                                        )
                                )
                            
                            Image(systemName: "plus")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.black)
                        }
                    } else {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: tab.iconName)
                                .font(.system(size: 18, weight: isSelected ? .bold : .medium))
                                .foregroundColor(isSelected ? .white : Theme.textTertiary)
                                .scaleEffect(isSelected ? 1.05 : 1.0)
                            
                            // Badge pill (e.g. 99+ or LIVE as seen on screenshot)
                            if tab == .wallet {
                                Text("PRO")
                                    .font(.system(size: 8, weight: .black))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 1.5)
                                    .background(Capsule().fill(Theme.neonGreen.opacity(0.9)))
                                    .foregroundColor(.black)
                                    .offset(x: 12, y: -8)
                            } else if tab == .management {
                                Circle()
                                    .fill(Theme.neonGreen)
                                    .frame(width: 6, height: 6)
                                    .shadow(color: Theme.neonGreen, radius: 4)
                                    .offset(x: 6, y: -6)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .contentShape(Rectangle())
            }
        }
        .buttonStyle(.plain)
    }
    
    private func select(_ tab: TabItem) {
        if selectedTab != tab {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                selectedTab = tab
            }
        }
    }
}
