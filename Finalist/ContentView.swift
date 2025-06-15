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
                    
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .ranked) }) { Text("Ranked") }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .sponsor) }) { Text("Sponsor") }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .worldtour) }) { Text("World Tour") }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .powershift) }) { Text("Power Shift") }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .quickcash) }) { Text("Quick Cash") }
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .tdm) }) { Text("Team Deathmatch")}
                    NavigationLink(destination: { LeaderboardView(leaderboardType: .terminalattack) }) { Text("Terminal Attack") }
                    
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
