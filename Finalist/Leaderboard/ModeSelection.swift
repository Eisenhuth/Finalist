import SwiftUI

enum Modes {
    case Archive
    case Live
}

struct ModeSelection: View {
    @Binding var mode: Modes
    let selectedFont: Font = .finalsButtonEmphasis(35)
    let normalFont: Font = .finalsButton(30)
    
    var body: some View {
        HStack {
            Text("ARCHIVE")
                .onTapGesture { mode = .Archive }
                .font(mode == .Archive ? selectedFont : normalFont)
            Text("I")
                .font(normalFont)
            Text("LIVE")
                .onTapGesture { mode = .Live }
                .font(mode == .Live ? selectedFont : normalFont)
        }
        .frame(height: 35)
    }
}

#Preview {
    ModeSelection(mode: .constant(.Live))
}
