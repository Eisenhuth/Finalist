import SwiftUI
import Ospuze

struct SeasonPicker: View {
    @Binding var selection: Leaderboards.identifiers
    var leaderboardType: LeaderboardType
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(getLeaderboardsByType(leaderboardType), id: \.rawValue) {
                Text(getSeasonFromIdentifier($0)).tag($0)
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    @Previewable @State var selection: Leaderboards.identifiers = .S7_Crossplay
    
    SeasonPicker(selection: $selection, leaderboardType: .ranked)
}
