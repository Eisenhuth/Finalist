import SwiftUI

struct ContentView: View {
    @State private var selectedMode: Modes = .Live
    @State private var selectedSeason: Seasons = .Season5
    @State private var showingSettings = false
    var backgroundColor: Color {
        switch selectedSeason {
        case .ClosedBeta1, .ClosedBeta2, .OpenBeta, .Season1, .Season3, .Season4, .Season5:
                .finalsRed
        case .Season2:
                .finalsPurple
        }
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(backgroundColor)
                    .ignoresSafeArea()
                
                VStack{
                    Text("LEADERBOARDS")
                        .font(.finalsHeader(50))
                        .frame(height: 50)
                    
                    SeasonSelection(leaderboard: $selectedSeason)
                    switch selectedSeason {
                    case .ClosedBeta1, .ClosedBeta2, .OpenBeta, .Season1:
                        LeaderboardViewV1()
                    case .Season2:
                        LeaderboardViewV2()
                    case .Season3:
                        LeaderboardViewV3(archived: true, theme: .finalsDarkRed, leaderboards: [.S3_Crossplay, .S3_Worldtour])
                    case .Season4:
                        LeaderboardViewV3(archived: true, theme: .finalsRed, leaderboards: [.S4_Crossplay, .S4_Worldtour, .S4_Sponsor])
                    case .Season5:
                        LeaderboardViewV3(archived: false, theme: .finalsRed, leaderboards: [.S5_Crossplay, .S5_Worldtour, .S5_Sponsor])
                    }
                }
            }
            .foregroundStyle(.finalsWhite)
        }
    }
}

#Preview {
    ContentView()
}
