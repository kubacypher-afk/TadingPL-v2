import SwiftUI

@main
struct TradingApp: App {
    @State private var appState = AppState()
    @State private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Theme.backgroundDark.ignoresSafeArea()
                
                if appState.isAuthenticated {
                    MainTabView()
                        .transition(.asymmetric(
                            insertion: .scale(scale: 1.04).combined(with: .opacity),
                            removal: .scale(scale: 0.96).combined(with: .opacity)
                        ))
                } else {
                    AuthView(viewModel: authViewModel) {
                        appState.completeAuth()
                    }
                    .transition(.asymmetric(
                        insertion: .opacity,
                        removal: .scale(scale: 0.96).combined(with: .opacity)
                    ))
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}
