import SwiftUI
import Ospuze

struct LeaderboardSelection: View {
    @Binding var selection: Leaderboards.identifiers
    let selectedFont: Font = .finalsButtonEmphasis(35)
    let normalFont: Font = .finalsButton(30)
    
    var body: some View {
        HStack{
            Text("CB1")
                .onTapGesture { selection = .ClosedBeta1 }
                .font(selection == .ClosedBeta1 ? selectedFont : normalFont)
            Text("CB2")
                .onTapGesture { selection = .ClosedBeta2 }
                .font(selection == .ClosedBeta2 ? selectedFont : normalFont)
            Text("OB")
                .onTapGesture { selection = .OpenBeta }
                .font(selection == .OpenBeta ? selectedFont : normalFont)
            Text("S1 [LIVE]")
                .onTapGesture { selection = .LiveCrossplay }
                .font(selection == .LiveCrossplay ? selectedFont : normalFont)

        }
    }
}

#Preview {
    LeaderboardSelection(selection: .constant(.LiveCrossplay))
}
