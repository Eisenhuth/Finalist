import SwiftUI

struct LeaderboardSelection: View {
    @Binding var selection: String
    let selectedFont: Font = .finalsButtonEmphasis(35)
    let normalFont: Font = .finalsButton(30)
    
    var body: some View {
        HStack{
            Text("CB1")
                .onTapGesture { selection = "CB1" }
                .font(selection == "CB1" ? selectedFont : normalFont)
            Text("CB2")
                .onTapGesture { selection = "CB2" }
                .font(selection == "CB2" ? selectedFont : normalFont)
            Text("OB")
                .onTapGesture { selection = "OB" }
                .font(selection == "OB" ? selectedFont : normalFont)
            Text("S1 [LIVE]")
                .onTapGesture { selection = "S1" }
                .font(selection == "S1" ? selectedFont : normalFont)

        }
    }
}

#Preview {
    LeaderboardSelection(selection: .constant("S1"))
}
