import SwiftUI

public struct LiveOscilloscopeChart: View {
    private let height: CGFloat
    
    public init(height: CGFloat = 80) {
        self.height = height
    }
    
    public var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 60.0)) { timeline in
            let elapsed = timeline.date.timeIntervalSinceReferenceDate
            Canvas { context, size in
                drawWave(in: &context, size: size, elapsed: elapsed)
            }
        }
        .frame(height: height)
    }
    
    private func drawWave(in context: inout GraphicsContext, size: CGSize, elapsed: Double) {
        let midY = size.height / 2.0
        let width = size.width
        let step: CGFloat = 3.0
        
        var path = Path()
        let count = Int(width / step) + 1
        
        for i in 0..<count {
            let x = CGFloat(i) * step
            let progress = x / width
            
            // Multi-frequency wave calculation for organic crypto oscilloscope effect
            let freq1 = 0.035
            let freq2 = 0.08
            let freq3 = 0.015
            
            let phase1 = elapsed * 3.5
            let phase2 = elapsed * 2.0
            
            // Envelope damping at extreme edges
            let envelope = sin(progress * .pi)
            
            let wave1 = sin(Double(x) * freq1 + phase1) * 14.0
            let wave2 = cos(Double(x) * freq2 - phase2) * 6.0
            let wave3 = sin(Double(x) * freq3 + elapsed) * 4.0
            
            let y = midY + CGFloat((wave1 + wave2 + wave3) * envelope)
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        // 1. Wide diffuse background glow
        context.stroke(
            path,
            with: .color(Theme.neonGreen.opacity(0.2)),
            style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
        )
        
        // 2. Focused vibrant inner glow
        context.stroke(
            path,
            with: .color(Theme.neonGreen.opacity(0.6)),
            style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)
        )
        
        // 3. Crisp white-mint core filament
        context.stroke(
            path,
            with: .color(Color.white.opacity(0.95)),
            style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round)
        )
        
        // 4. Trailing energy particle near right side
        let particleX = width * 0.95
        let particleEnvelope = sin((particleX / width) * .pi)
        let particleY = midY + CGFloat((sin(Double(particleX) * 0.035 + elapsed * 3.5) * 14.0) * particleEnvelope)
        
        let glowRect = CGRect(x: particleX - 10, y: particleY - 10, width: 20, height: 20)
        let coreRect = CGRect(x: particleX - 3.5, y: particleY - 3.5, width: 7, height: 7)
        
        context.fill(Path(ellipseIn: glowRect), with: .color(Theme.neonGreen.opacity(0.5)))
        context.fill(Path(ellipseIn: coreRect), with: .color(.white))
    }
}
