import SwiftUI
import UIKit

public struct WalletView: View {
    @State private var cardTilt: CGFloat = 0.0
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AmbientBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    HStack {
                        GlowingLiveBadge("PRO WALLET")
                        Spacer()
                        Text("Multi-Chain EVM + SOL")
                            .font(Typography.caption(11))
                            .foregroundColor(Theme.textTertiary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    
                    // Holographic Glass Crypto Card
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("TRADING DESK VAULT")
                                .font(Typography.ticker(13))
                                .fontWeight(.bold)
                                .foregroundColor(.white.opacity(0.85))
                            Spacer()
                            Image(systemName: "wave.3.right")
                                .foregroundColor(Theme.neonGreen)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("ŁĄCZNE SALDO")
                                .font(Typography.caption(10))
                                .foregroundColor(.white.opacity(0.6))
                            Text("$14,820.50")
                                .font(.system(size: 32, weight: .black, design: .rounded))
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            Text("••••  ••••  ••••  9482")
                                .font(Typography.ticker(13))
                                .foregroundColor(.white.opacity(0.7))
                            Spacer()
                            Text("0x71F...89A")
                                .font(Typography.ticker(11))
                                .foregroundColor(Theme.neonGreen)
                        }
                    }
                    .padding(24)
                    .frame(height: 200)
                    .background(
                        ZStack {
                            LinearGradient(
                                colors: [
                                    Color(red: 0.14, green: 0.17, blue: 0.24),
                                    Color(red: 0.08, green: 0.09, blue: 0.13)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            
                            // Metallic specular shimmer
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.12),
                                    Color.clear,
                                    Theme.neonGreen.opacity(0.15)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.35), Color.white.opacity(0.08)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.2
                            )
                    )
                    .shadow(color: Color.black.opacity(0.5), radius: 18, x: 0, y: 10)
                    .shadow(color: Theme.neonGreen.opacity(0.1), radius: 14)
                    .padding(.horizontal, 20)
                    
                    // Quick Action Buttons
                    HStack(spacing: 12) {
                        walletActionButton(title: "Wpłać", icon: "arrow.down.left", isPrimary: true)
                        walletActionButton(title: "Wyślij", icon: "arrow.up.right", isPrimary: false)
                        walletActionButton(title: "Swap", icon: "arrow.triangle.2.circlepath", isPrimary: false)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 120)
            }
        }
    }
    
    private func walletActionButton(title: String, icon: String, isPrimary: Bool) -> some View {
        Button(action: {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .bold))
                Text(title)
                    .font(Typography.body(13, weight: .bold))
            }
            .foregroundColor(isPrimary ? .black : .white)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isPrimary ? Theme.neonGreen : Color.white.opacity(0.06))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isPrimary ? Color.clear : Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}
