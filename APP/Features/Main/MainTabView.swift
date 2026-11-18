import SwiftUI

public struct MainTabView: View {
    @State private var selectedTab: TabItem = .home
    @State private var homeViewModel = HomeViewModel()
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 0.05, green: 0.055, blue: 0.07)
                .ignoresSafeArea()
            
            Group {
                switch selectedTab {
                case .home:
                    HomeView(viewModel: homeViewModel)
                case .management:
                    ManagementView()
                case .radar:
                    RadarView()
                case .wallet:
                    WalletView()
                case .history:
                    HistoryView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            FloatingGlassTabBar(selectedTab: $selectedTab)
                .padding(.horizontal, 24)
                .padding(.bottom, 14)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
