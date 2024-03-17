import SwiftUI
import Ospuze

struct ArchiveSelection: View {
    @Binding var archive: Leaderboards.archives
    let selectedFont: Font = .finalsButtonEmphasis(30)
    let normalFont: Font = .finalsButton(25)
    
    var body: some View {
        HStack {
            Text("CB1")
                .onTapGesture { archive = .ClosedBeta1 }
                .font(archive == .ClosedBeta1 ? selectedFont : normalFont)
            Text("I")
                .font(normalFont)
            Text("CB2")
                .onTapGesture { archive = .ClosedBeta2 }
                .font(archive == .ClosedBeta2 ? selectedFont : normalFont)
            Text("I")
                .font(normalFont)
            Text("OB")
                .onTapGesture { archive = .OpenBeta }
                .font(archive == .OpenBeta ? selectedFont : normalFont)
            Text("I")
                .font(normalFont)
            Text("S1")
                .onTapGesture { archive = .S1_Crossplay }
                .font(archive.rawValue.contains("S1") ? selectedFont : normalFont)
        }
        .frame(height: 30)
    }
}

#Preview {
    ArchiveSelection(archive: .constant(.S1_Crossplay))
}
