import SwiftUI

struct ContentView: View {
    @State private var showingSettings = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.finalsRed
                    .ignoresSafeArea()
                
                VStack(alignment: .trailing) {
                    
                    Text("LEADERBOARDS")
                        .font(.finalsHeader(50))
                        .frame(height: 50)
                    
                    Spacer()
                    
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .ranked) }) { Text(LeaderboardType.ranked.rawValue) }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .sponsor) }) { Text(LeaderboardType.sponsor.rawValue) }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .worldtour) }) { Text(LeaderboardType.worldtour.rawValue) }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .powershift) }) { Text(LeaderboardType.powershift.rawValue) }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .quickcash) }) { Text(LeaderboardType.quickcash.rawValue) }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .tdm) }) { Text(LeaderboardType.tdm.rawValue)}
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .head2head) }) { Text(LeaderboardType.head2head.rawValue) }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .terminalattack) }) { Text(LeaderboardType.terminalattack.rawValue) }
                    
                    Spacer()
                    
                    NavigationLink(destination: { SettingsView() }) { Text("Settings") }

                    Spacer()
                }
                .textCase(.uppercase)
                .font(.finalsButtonEmphasis(40))
                .foregroundStyle(.finalsWhite)
            }
        }
        .tint(.finalsWhite)
    }
}

#Preview {
    ContentView()
}
