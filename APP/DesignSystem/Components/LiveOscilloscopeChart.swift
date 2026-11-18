import SwiftUI

public struct LiveOscilloscopeChart: View {
    private let height: CGFloat
    @State private var touchLocation: CGPoint? = nil
    
    public init(height: CGFloat = 85) {
        self.height = height
    }
    
    public var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 60.0)) { timeline in
            let elapsed = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                drawBackgroundGrid(in: &context, size: size)
                drawWaveUnderlay(in: &context, size: size, elapsed: elapsed)
                drawGlowingWave(in: &context, size: size, elapsed: elapsed)
                drawTravelingPhotons(in: &context, size: size, elapsed: elapsed)
            }
        }
        .frame(height: height)
        .overlay(
            // Subtle top and bottom neon laser horizon lines
            VStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color.clear, Theme.neonGreen.opacity(0.15), Color.clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 1)
                Spacer()
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color.clear, Theme.neonGreen.opacity(0.1), Color.clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 1)
            }
        )
    }
    
    private func drawBackgroundGrid(in context: inout GraphicsContext, size: CGSize) {
        let gridStep: CGFloat = 40.0
        let cols = Int(size.width / gridStep)
        
        for c in 1...cols {
            let x = CGFloat(c) * gridStep
            var gridLine = Path()
            gridLine.move(to: CGPoint(x: x, y: 0))
            gridLine.addLine(to: CGPoint(x: x, y: size.height))
            context.stroke(
                gridLine,
                with: .color(Color.white.opacity(0.025)),
                style: StrokeStyle(lineWidth: 1, dash: [2, 4])
            )
        }
    }
    
    private func drawWaveUnderlay(in context: inout GraphicsContext, size: CGSize, elapsed: Double) {
        let midY = size.height / 2.0
        let width = size.width
        let step: CGFloat = 4.0
        let count = Int(width / step) + 1
        
        var fillPath = Path()
        fillPath.move(to: CGPoint(x: 0, y: size.height))
        
        for i in 0..<count {
            let x = CGFloat(i) * step
            let progress = x / width
            let envelope = sin(progress * .pi)
            
            let y = midY + CGFloat(
                (sin(Double(x) * 0.038 + elapsed * 3.2) * 16.0 +
                 cos(Double(x) * 0.082 - elapsed * 2.1) * 7.0) * envelope
            )
            
            fillPath.addLine(to: CGPoint(x: x, y: y))
        }
        
        fillPath.addLine(to: CGPoint(x: width, y: size.height))
        fillPath.closeSubpath()
        
        context.fill(
            fillPath,
            with: .linearGradient(
                Gradient(colors: [
                    Theme.neonGreen.opacity(0.12),
                    Theme.neonGreen.opacity(0.02),
                    Color.clear
                ]),
                startPoint: CGPoint(x: 0, y: midY - 20),
                endPoint: CGPoint(x: 0, y: size.height)
            )
        )
    }
    
    private func drawGlowingWave(in context: inout GraphicsContext, size: CGSize, elapsed: Double) {
        let midY = size.height / 2.0
        let width = size.width
        let step: CGFloat = 3.0
        let count = Int(width / step) + 1
        
        var wavePath = Path()
        
        for i in 0..<count {
            let x = CGFloat(i) * step
            let progress = x / width
            let envelope = sin(progress * .pi)
            
            let y = midY + CGFloat(
                (sin(Double(x) * 0.038 + elapsed * 3.2) * 16.0 +
                 cos(Double(x) * 0.082 - elapsed * 2.1) * 7.0) * envelope
            )
            
            if i == 0 {
                wavePath.move(to: CGPoint(x: x, y: y))
            } else {
                wavePath.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        // 1. Atmosphere Aura Glow
        context.stroke(
            wavePath,
            with: .color(Theme.neonGreen.opacity(0.25)),
            style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round)
        )
        
        // 2. Focused Neon Core
        context.stroke(
            wavePath,
            with: .color(Theme.neonGreen.opacity(0.85)),
            style: StrokeStyle(lineWidth: 3.5, lineCap: .round, lineJoin: .round)
        )
        
        // 3. Ultra-Bright Laser Filament
        context.stroke(
            wavePath,
            with: .color(Color.white.opacity(0.98)),
            style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round)
        )
    }
    
    private func drawTravelingPhotons(in context: inout GraphicsContext, size: CGSize, elapsed: Double) {
        let midY = size.height / 2.0
        let width = size.width
        
        // 3 traveling energy packets along the wave
        for p in 0..<3 {
            let phaseOffset = Double(p) * 0.33
            let progress = (elapsed * 0.25 + phaseOffset).truncatingRemainder(dividingBy: 1.0)
            let x = CGFloat(progress) * width
            let envelope = sin(CGFloat(progress) * .pi)
            
            let y = midY + CGFloat(
                (sin(Double(x) * 0.038 + elapsed * 3.2) * 16.0 +
                 cos(Double(x) * 0.082 - elapsed * 2.1) * 7.0) * envelope
            )
            
            let halo = CGRect(x: x - 9, y: y - 9, width: 18, height: 18)
            let core = CGRect(x: x - 3, y: y - 3, width: 6, height: 6)
            
            context.fill(Path(ellipseIn: halo), with: .color(Theme.neonGreen.opacity(0.45)))
            context.fill(Path(ellipseIn: core), with: .color(.white))
        }
    }
}
