import SwiftUI

public struct RadarView: View {
    @State private var scanAngle: Double = 0
    @State private var pingScale: CGFloat = 0.8
    @State private var pingOpacity: Double = 0.8
    
    private let radarSignals = [
        ("SOL / USDT", "Breakout Impuls", "+14.2%"),
        ("AVAX / USDT", "Whale Buy 2.4M", "+8.7%"),
        ("NEAR / USDT", "Orderbook Squeeze", "+19.1%")
    ]
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AmbientBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    HStack {
                        GlowingLiveBadge("RADAR SCANNER")
                        Spacer()
                        Text("3 Cele wykryte")
                            .font(Typography.ticker(12))
                            .foregroundColor(Theme.neonGreen)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    
                    // Animated Circular Radar Display
                    ZStack {
                        // Concentric rings
                        ForEach([60, 110, 160, 210], id: \.self) { radius in
                            Circle()
                                .stroke(Theme.neonGreen.opacity(0.15), lineWidth: 1)
                                .frame(width: CGFloat(radius * 2), height: CGFloat(radius * 2))
                        }
                        
                        // Crosshairs
                        Rectangle()
                            .fill(Theme.neonGreen.opacity(0.12))
                            .frame(width: 420, height: 1)
                        Rectangle()
                            .fill(Theme.neonGreen.opacity(0.12))
                            .frame(width: 1, height: 420)
                        
                        // Rotating Radar Beam
                        Circle()
                            .fill(
                                AngularGradient(
                                    colors: [
                                        Theme.neonGreen.opacity(0.4),
                                        Theme.neonGreen.opacity(0.1),
                                        Color.clear,
                                        Color.clear
                                    ],
                                    center: .center,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(180)
                                )
                            )
                            .frame(width: 420, height: 420)
                            .rotationEffect(.degrees(scanAngle))
                        
                        // Blip 1
                        Circle()
                            .fill(Theme.neonGreen)
                            .frame(width: 8, height: 8)
                            .shadow(color: Theme.neonGreen, radius: 8)
                            .offset(x: 55, y: -70)
                        
                        // Blip 2
                        Circle()
                            .fill(Color.cyan)
                            .frame(width: 7, height: 7)
                            .shadow(color: Color.cyan, radius: 8)
                            .offset(x: -80, y: 40)
                        
                        // Blip 3
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 7, height: 7)
                            .shadow(color: Color.orange, radius: 8)
                            .offset(x: 100, y: 80)
                    }
                    .frame(height: 300)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white.opacity(0.1), lineWidth: 1.5)
                    )
                    
                    // Detected Signals Feed
                    VStack(alignment: .leading, spacing: 12) {
                        Text("AKTYWNE SYGNAŁY RADARU")
                            .font(Typography.ticker(13))
                            .fontWeight(.bold)
                            .foregroundColor(Theme.textSecondary)
                        
                        ForEach(radarSignals, id: \.0) { signal in
                            HStack {
                                Circle()
                                    .fill(Theme.neonGreen)
                                    .frame(width: 6, height: 6)
                                    .shadow(color: Theme.neonGreen, radius: 4)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(signal.0)
                                        .font(Typography.ticker(14))
                                        .fontWeight(.bold)
                                        .foregroundColor(Theme.textPrimary)
                                    Text(signal.1)
                                        .font(Typography.caption(12))
                                        .foregroundColor(Theme.textSecondary)
                                }
                                
                                Spacer()
                                
                                Text(signal.2)
                                    .font(Typography.ticker(13))
                                    .fontWeight(.bold)
                                    .foregroundColor(Theme.neonGreen)
                            }
                            .padding(14)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(red: 0.08, green: 0.10, blue: 0.14).opacity(0.8))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.06), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 120)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 4.0).repeatForever(autoreverses: false)) {
                scanAngle = 360
            }
        }
    }
}
