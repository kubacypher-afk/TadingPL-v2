import Foundation

public enum AuthMode: String, CaseIterable, Identifiable {
    case login = "Logowanie"
    case register = "Rejestracja"
    
    public var id: String { rawValue }
}
