import SwiftUI

public struct CryptoTrade: Identifiable, Sendable {
    public let id: UUID
    public let pair: String
    public let strategy: String
    public let status: String
    public let timeAgo: String
    public let profitAmount: String
    public let profitPercentage: String
    public let isPositive: Bool
    public let avatarLetter: String
    public let avatarColor: Color
    
    public init(
        id: UUID = UUID(),
        pair: String,
        strategy: String,
        status: String,
        timeAgo: String,
        profitAmount: String,
        profitPercentage: String,
        isPositive: Bool = true,
        avatarLetter: String,
        avatarColor: Color
    ) {
        self.id = id
        self.pair = pair
        self.strategy = strategy
        self.status = status
        self.timeAgo = timeAgo
        self.profitAmount = profitAmount
        self.profitPercentage = profitPercentage
        self.isPositive = isPositive
        self.avatarLetter = avatarLetter
        self.avatarColor = avatarColor
    }
}
