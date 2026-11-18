import SwiftUI

public struct AmbientBackground: View {
    public init() {}
    
    public var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.05, green: 0.06, blue: 0.08),
                Color(red: 0.03, green: 0.035, blue: 0.045),
                Color(red: 0.02, green: 0.025, blue: 0.03)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
