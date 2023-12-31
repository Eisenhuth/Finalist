import SwiftUI
import Ospuze

struct LeaderboardSelection: View {
    @Binding var selectedLive: Leaderboards.identifiers
    @Binding var selectedArchive: Leaderboards.archives
    @Binding var selectedMode: LeaderboardView.mode
    let selectedFont: Font = .finalsButtonEmphasis(35)
    let normalFont: Font = .finalsButton(30)
    
    var body: some View {
        VStack(spacing: -10){
            HStack{
                Text("Archive")
                    .onTapGesture { selectedMode = .archive }
                    .font(selectedMode == .archive ? selectedFont : normalFont)
                Text("I")
                    .font(selectedFont)
                Text("Live")
                    .onTapGesture { selectedMode = .live }
                    .font(selectedMode ==  .live ? selectedFont : normalFont)
            }
            
            if selectedMode == .archive {
                HStack{
                    Text("CB1")
                        .onTapGesture { selectedArchive = .ClosedBeta1 }
                        .font(selectedArchive == .ClosedBeta1 ? selectedFont : normalFont)
                    Text("CB2")
                        .onTapGesture { selectedArchive = .ClosedBeta2 }
                        .font(selectedArchive == .ClosedBeta2 ? selectedFont : normalFont)
                    Text("OB")
                        .onTapGesture { selectedArchive = .OpenBeta }
                        .font(selectedArchive == .OpenBeta ? selectedFont : normalFont)
                }
                .frame(height: 40)
            } else {
                HStack{
                    Image("Embark")
                        .resizable()
                        .renderingMode(.template)
                        .frame(
                            width: selectedLive == .LiveCrossplay ? 35 : 30,
                            height: selectedLive == .LiveCrossplay ? 35 : 30
                        )
                        .onTapGesture { selectedLive = .LiveCrossplay }
                    Image("Steam")
                        .resizable()
                        .renderingMode(.template)
                        .frame(
                            width: selectedLive == .LiveSteam ? 35 : 30,
                            height: selectedLive == .LiveSteam ? 35 : 30
                        )
                        .onTapGesture { selectedLive = .LiveSteam }
                    Text("\(Image(systemName: "playstation.logo"))")
                        .onTapGesture { selectedLive = .LivePSN }
                        .font(selectedLive == .LivePSN ? selectedFont : normalFont)
                    Text("\(Image(systemName: "xbox.logo"))")
                        .onTapGesture { selectedLive = .LiveXbox }
                        .font(selectedLive == .LiveXbox ? selectedFont : normalFont)
                }
                .frame(height: 40)
            }
             
        }
    }
}

#Preview {
    LeaderboardSelection(selectedLive: .constant(.LiveCrossplay), selectedArchive: .constant(.OpenBeta), selectedMode: .constant(.live))
}
