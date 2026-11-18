import SwiftUI

public enum TabItem: String, CaseIterable, Identifiable {
    case home = "Home"
    case management = "Management"
    case radar = "Radar"
    case wallet = "Wallet"
    case history = "History"
    
    public var id: String { rawValue }
    
    public var iconName: String {
        switch self {
        case .home:
            return "house.fill"
        case .management:
            return "slider.horizontal.3"
        case .radar:
            return "dot.radiowaves.left.and.right"
        case .wallet:
            return "creditcard.fill"
        case .history:
            return "clock.arrow.circlepath"
        }
    }
}
