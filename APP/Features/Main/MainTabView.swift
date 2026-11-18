import SwiftUI

public struct MainTabView: View {
    @State private var selectedTab: TabItem = .home
    @State private var homeViewModel = HomeViewModel()
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            Theme.backgroundDark.ignoresSafeArea()
            
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
            
            CyberTabBar(selectedTab: $selectedTab)
        }
    }
}
