import SwiftUI

struct ContentView: View {
    @State private var selectedMode: Modes = .Live
    @State private var selectedSeason: Seasons = .Season3
    @State private var showingSettings = false
    var backgroundColor: Color {
        switch selectedSeason {
        case .ClosedBeta1, .ClosedBeta2, .OpenBeta, .Season1:
                .finalsRed
        case .Season2:
                .finalsPurple
        case .Season3:
                .finalsRed
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
                        LeaderboardViewV3()
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
