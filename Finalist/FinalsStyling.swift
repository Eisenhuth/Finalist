import SwiftUI

struct FinalsStyling: ViewModifier {
    func body(content: Content) -> some View {
    
        ZStack {
            Color.finalsRed
                .ignoresSafeArea()
            
            content
                .textCase(.uppercase)
                .foregroundStyle(.finalsWhite)
                .tint(.finalsWhite)
                .listRowBackground(Color.finalsWhite.opacity(0.1))
                .listRowSeparatorTint(.secondary)
        }
    }
}

struct FinalsSectionStyling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.finalsWhite.opacity(0.1))
            .listRowSeparatorTint(.secondary)
    }
}

extension View {
    func finalsStyling() -> some View {
        self.modifier(FinalsStyling())
    }
    
    func finalsSectionStyling() -> some View {
        self.modifier(FinalsSectionStyling())
    }
}

#Preview {
    ContentView()
        .finalsStyling()
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
