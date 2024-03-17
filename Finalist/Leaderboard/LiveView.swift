import SwiftUI
import Ospuze

struct LiveView: View {
    @State private var leaderboard: [LeaderboardEntryV2]?
    @State private var selectedPlatform: Platforms = .Crossplay
    @State private var selectedLeaderboard: Leaderboards.idenfifiersV2 = .LiveCrossplay
    @State private var searchText = ""
    var theme: Color = .finalsPurple
    var seasonTitle = "SEASON 2"
    
    var body: some View {
        ZStack{
            
            Color.finalsPurple
                .ignoresSafeArea()
                
            VStack{
                PlatformSelection(platform: $selectedPlatform)
                SearchBar(searchText: $searchText).foregroundStyle(theme)
                
                GeometryReader{gr in
                    let columns =  [
                        GridItem(.fixed(gr.size.width * 0.15)), //Rank
                        GridItem(.fixed(gr.size.width * 0.20)), //24h
                        GridItem(.fixed(gr.size.width * 0.40)), //Name
                        GridItem(.fixed(gr.size.width * 0.20))  //League
                    ]
                    
                    VStack{
                        LazyVGrid(columns: columns, content: {
                            GridRow {
                                Text("Rank")
                                Text("24h")
                                Text("Name")
                                Text("League")
                            }
                        })
                        .font(.finalsBodyEmphasis())
                        
                        Divider()
                            .frame(minHeight: 3)
                            .overlay(.finalsWhite)
                            .padding(.horizontal)
                        
                        ScrollView{
                            LazyVGrid(columns: columns, content: {
                                if let leaderboard = searchText.isEmpty ? leaderboard : leaderboard?.filter({ $0.name.lowercased().contains(searchText.lowercased()) }){
                                    
                                    ForEach(leaderboard, id: \.self){entry in
                                        
                                        GridRow{
                                            Text(entry.r.description)
                                                .font(.finalsBodyEmphasis())
                                                .monospacedDigit()
                                            
                                            Text(entry.rankChange != 0 ? " "+entry.formattedRankChange : "")
                                                .monospaced()
                                                .font(.finalsBody(16))
                                            
                                            Text(entry.name)
                                            
                                            
                                            Image(entry.leagueName)
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                            
                                            
                                        }
                                        .lineLimit(1)
                                    }
                                }
                            })
                            if leaderboard == nil {
                                ContentUnavailableView("no data", systemImage: "list.number")
                            }
                        }
                    }
                }
                .font(.finalsBody(16))
            }
        }
        .foregroundStyle(.finalsWhite)
        .tint(theme)
        .task { loadLeaderboard() }
        .onChange(of: selectedPlatform) {
            selectedLeaderboard = switch selectedPlatform {
            case .Crossplay: .LiveCrossplay
            case .Steam: .LiveSteam
            case .PSN: .LivePSN
            case .Xbox: .LiveXbox
            }
            loadLeaderboard()
        }
    }
    
    func loadLeaderboard(){
        Task{
            leaderboard = await Leaderboards.getLeaderboardV2(selectedLeaderboard)
        }
    }
}

#Preview {
    LiveView()
}
