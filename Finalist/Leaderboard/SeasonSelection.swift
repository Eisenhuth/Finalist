import SwiftUI

enum Seasons {
    case ClosedBeta1
    case ClosedBeta2
    case OpenBeta
    case Season1
    case Season2
    case Season3
    case Season4
    case Season5
    case Season6
}

struct SeasonSelection: View {
    @Binding var leaderboard: Seasons
    let selectedFont: Font = .finalsButtonEmphasis(35)
    let normalFont: Font = .finalsButton(30)
    
    var body: some View {
        HStack {
            Text("CB1 - S1")
                .onTapGesture { leaderboard = .Season1 }
                .font(leaderboard == .Season1 ? selectedFont : normalFont)
            Text("I")
                .font(normalFont)
            Text("S2")
                .onTapGesture { leaderboard = .Season2 }
                .font(leaderboard == .Season2 ? selectedFont : normalFont)
            Text("I")
                .font(normalFont)
            Text("S3")
                .onTapGesture { leaderboard = .Season3 }
                .font(leaderboard == .Season3 ? selectedFont : normalFont)
            Text("I")
                .font(normalFont)
            Text("S4")
                .onTapGesture { leaderboard = .Season4 }
                .font(leaderboard == .Season4 ? selectedFont : normalFont)
            Text("I")
                .font(normalFont)
            Text("S5")
                .onTapGesture { leaderboard = .Season5 }
                .font(leaderboard == .Season5 ? selectedFont : normalFont)
            Text("I")
                .font(normalFont)
            Text("S6")
                .onTapGesture { leaderboard = .Season6 }
                .font(leaderboard == .Season6 ? selectedFont : normalFont)
            
        }
        .frame(height: 35)
    }
}

#Preview {
    SeasonSelection(leaderboard: .constant(.Season3))
}
