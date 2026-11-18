import SwiftUI

public enum Typography {
    public static func monoHeading(_ size: CGFloat, weight: Font.Weight = .bold) -> Font {
        Font.system(size: size, weight: weight, design: .monospaced)
    }
    
    public static func headline(_ size: CGFloat, weight: Font.Weight = .bold) -> Font {
        Font.system(size: size, weight: weight, design: .default)
    }
    
    public static func body(_ size: CGFloat = 15, weight: Font.Weight = .regular) -> Font {
        Font.system(size: size, weight: weight, design: .default)
    }
    
    public static func caption(_ size: CGFloat = 12, weight: Font.Weight = .medium) -> Font {
        Font.system(size: size, weight: weight, design: .default)
    }
    
    public static func ticker(_ size: CGFloat = 13) -> Font {
        Font.system(size: size, weight: .semibold, design: .monospaced)
    }
}
