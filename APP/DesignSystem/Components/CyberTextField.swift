import SwiftUI

public struct CyberTextField: View {
    private let title: String
    private let icon: String
    private let isSecure: Bool
    private let keyboardType: UIKeyboardType
    @Binding private var text: String
    
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isFocused: Bool
    
    public init(
        _ title: String,
        icon: String,
        text: Binding<String>,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default
    ) {
        self.title = title
        self.icon = icon
        self._text = text
        self.isSecure = isSecure
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(isFocused ? Theme.neonGreen : Theme.textTertiary)
                .frame(width: 22)
            
            if isSecure && !isPasswordVisible {
                SecureField("", text: $text, prompt: promptText)
                    .focused($isFocused)
                    .foregroundColor(Theme.textPrimary)
                    .font(Typography.body(15))
                    .textContentType(.none)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            } else {
                TextField("", text: $text, prompt: promptText)
                    .focused($isFocused)
                    .foregroundColor(Theme.textPrimary)
                    .font(Typography.body(15))
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(keyboardType == .emailAddress ? .never : .words)
            }
            
            if isSecure {
                Button(action: togglePasswordVisibility) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Theme.textTertiary)
                        .padding(4)
                }
            } else if !text.isEmpty {
                Button(action: clearText) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(Theme.textTertiary)
                        .padding(4)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Theme.cardBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    isFocused ? Theme.neonGreen.opacity(0.8) : Theme.cardBorder,
                    lineWidth: isFocused ? 1.5 : 1
                )
                .shadow(color: isFocused ? Theme.neonGlow : Color.clear, radius: 8)
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
    
    private var promptText: Text {
        Text(title).foregroundColor(Theme.textTertiary)
    }
    
    private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }
    
    private func clearText() {
        text = ""
    }
}
