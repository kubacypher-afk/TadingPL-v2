import SwiftUI

public enum Theme {
    // Primary Neon Accents
    public static let neonGreen = Color(red: 0.0, green: 1.0, blue: 0.64)       // #00FFA3
    public static let neonMint = Color(red: 0.15, green: 0.95, blue: 0.68)      // #27F2AD
    public static let neonGlow = Color(red: 0.0, green: 1.0, blue: 0.64, opacity: 0.4)
    public static let emeraldText = Color(red: 0.2, green: 0.88, blue: 0.6)
    
    // Backgrounds - Pure OLED Dark Theme
    public static let backgroundDark = Color(red: 0.039, green: 0.047, blue: 0.063) // #0A0C10
    public static let surfaceDark = Color(red: 0.067, green: 0.078, blue: 0.102)    // #11141A
    public static let cardBackground = Color(red: 0.086, green: 0.102, blue: 0.133) // #161A22
    public static let cardBorder = Color(white: 1.0, opacity: 0.12)
    public static let cardHighlight = Color(white: 1.0, opacity: 0.06)
    
    // Text and Secondary Accents
    public static let textPrimary = Color.white
    public static let textSecondary = Color(red: 0.65, green: 0.70, blue: 0.78)
    public static let textTertiary = Color(white: 0.52)
    public static let errorRed = Color(red: 1.0, green: 0.3, blue: 0.35)
    
    // Crypto Accents
    public static let solanaPurple = Color(red: 0.58, green: 0.31, blue: 0.98)
    public static let bitcoinOrange = Color(red: 0.96, green: 0.58, blue: 0.16)
    public static let ethereumBlue = Color(red: 0.38, green: 0.49, blue: 0.95)
    public static let pepeGreen = Color(red: 0.22, green: 0.74, blue: 0.42)
    
    // Linear Gradients
    public static let backgroundGradient = LinearGradient(
        colors: [
            Color(red: 0.04, green: 0.05, blue: 0.07),
            Color(red: 0.02, green: 0.025, blue: 0.035)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let neonLinear = LinearGradient(
        colors: [neonGreen, neonMint],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    public static let cardGradient = LinearGradient(
        colors: [
            Color(red: 0.09, green: 0.105, blue: 0.14),
            Color(red: 0.07, green: 0.08, blue: 0.11)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
