import SwiftUI

public struct AmbientBackground: View {
    @State private var animateGlow: Bool = false
    
    public init() {}
    
    public var body: some View {
        ZStack {
            // Deep OLED base
            Color(red: 0.04, green: 0.045, blue: 0.06)
                .ignoresSafeArea()
            
            // Top-left subtle emerald glow orb
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Theme.neonGreen.opacity(0.18),
                            Theme.neonGreen.opacity(0.04),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: 260
                    )
                )
                .frame(width: 480, height: 480)
                .offset(x: animateGlow ? -60 : -120, y: animateGlow ? -140 : -200)
                .blur(radius: 60)
            
            // Mid-right subtle cyan/indigo accent orb
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(red: 0.15, green: 0.45, blue: 0.95).opacity(0.14),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: 280
                    )
                )
                .frame(width: 450, height: 450)
                .offset(x: animateGlow ? 120 : 60, y: animateGlow ? 160 : 100)
                .blur(radius: 70)
            
            // Subtle digital scanline / dot grid
            Canvas { context, size in
                let spacing: CGFloat = 36.0
                let cols = Int(size.width / spacing) + 1
                let rows = Int(size.height / spacing) + 1
                
                for r in 0..<rows {
                    for c in 0..<cols {
                        let point = CGPoint(x: CGFloat(c) * spacing, y: CGFloat(r) * spacing)
                        let dot = Path(ellipseIn: CGRect(x: point.x, y: point.y, width: 1.2, height: 1.2))
                        context.fill(dot, with: .color(Color.white.opacity(0.035)))
                    }
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 6.0).repeatForever(autoreverses: true)) {
                animateGlow = true
            }
        }
    }
}
