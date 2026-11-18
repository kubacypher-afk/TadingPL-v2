import Foundation

public enum TimeframeFilter: String, CaseIterable, Identifiable {
    case live = "LIVE"
    case oneHour = "1H"
    case fourHours = "4H"
    case oneDay = "1D"
    case oneWeek = "1W"
    case all = "ALL"
    
    public var id: String { rawValue }
    
    public var displayTitle: String {
        switch self {
        case .live:
            return "● LIVE"
        default:
            return rawValue
        }
    }
}
