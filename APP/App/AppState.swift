import SwiftUI
import Observation

@Observable
@MainActor
public final class AppState {
    public var isAuthenticated: Bool = false
    
    public init() {}
    
    public func completeAuth() {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            isAuthenticated = true
        }
    }
    
    public func logout() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
            isAuthenticated = false
        }
    }
}
