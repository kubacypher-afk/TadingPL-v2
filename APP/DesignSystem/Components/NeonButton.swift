import SwiftUI
import UIKit

public struct NeonButton: View {
    private let title: String
    private let icon: String?
    private let isLoading: Bool
    private let action: () -> Void
    
    public init(
        _ title: String,
        icon: String? = nil,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        Button(action: handleTap) {
            HStack(spacing: 10) {
                if isLoading {
                    ProgressView()
                        .tint(.black)
                        .scaleEffect(0.9)
                } else {
                    if let icon {
                        Image(systemName: icon)
                            .font(.system(size: 16, weight: .bold))
                    }
                    Text(title)
                        .font(Typography.ticker(15))
                        .fontWeight(.bold)
                }
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Theme.neonLinear)
                    .shadow(color: Theme.neonGlow, radius: 12, x: 0, y: 4)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(PressableScaleButtonStyle())
        .disabled(isLoading)
    }
    
    private func handleTap() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        action()
    }
}

public struct PressableScaleButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}
