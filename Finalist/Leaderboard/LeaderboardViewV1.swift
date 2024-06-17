import SwiftUI
import Ospuze

struct LeaderboardViewV1: View {
    
    @State private var leaderboard: [LeaderboardEntry]?
    @State private var selectedArchive: Leaderboards.archives = .S1_Crossplay
    @State private var hasMultiplePlatforms = true
    @State private var selectedPlatform: Platforms = .Crossplay
    @State private var searchText = ""
    
        
    var body: some View {
        ZStack {
            Color.finalsRed
                .ignoresSafeArea()
            
            VStack {
                HStack{
                    ArchiveSelection(archive: $selectedArchive)
                        .padding(.horizontal)
                    
                    PlatformSelection(platform: $selectedPlatform)
                        .disabled(hasMultiplePlatforms == false)
                        .foregroundStyle(hasMultiplePlatforms == false
                                         ? .finalsWhite.opacity(0.50)
                                         : .finalsWhite
                        )
                        .padding(.horizontal)
                    
                }
                SearchBar(searchText: $searchText)
                    .foregroundStyle(.accent)
                
                Spacer()
                
                GeometryReader{gr in
                    let columns =  [
                        GridItem(.fixed(gr.size.width * 0.10)), //Rank
                        GridItem(.fixed(gr.size.width * 0.30)), //Name
                        GridItem(.fixed(gr.size.width * 0.25)), //Cashouts
                        GridItem(.fixed(gr.size.width * 0.25))  //Fame
                    ]
                    
                    VStack{
                        LazyVGrid(columns: columns, content: {
                            GridRow {
                                Text("Rank")
                                Text("Name")
                                Text("Cashouts")
                                Text("Fame")
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
                                            
                                            Text(entry.name)
                                            
                                            Text("$\(entry.c.formatted())")
                                                .monospacedDigit()
                                            Text(entry.f.description)
                                                .monospacedDigit()
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
        .task { loadLeaderboard() }
        .onChange(of: selectedArchive) {
            switch selectedArchive {
            case .ClosedBeta1, .ClosedBeta2, .OpenBeta:
                hasMultiplePlatforms = false
            default:
                hasMultiplePlatforms = true
            }
        }
        .onChange(of: hasMultiplePlatforms) {
            if hasMultiplePlatforms == false { selectedPlatform = .Crossplay }
        }
        .onChange(of: selectedArchive) { loadLeaderboard() }
        .onChange(of: selectedPlatform) {
            
            //problem for future me: deal with Season 2 being here
            //future me: thanks.
            if hasMultiplePlatforms {
                switch selectedPlatform {
                case .Crossplay:
                    selectedArchive = .S1_Crossplay
                case .Steam:
                    selectedArchive = .S1_Steam
                case .PSN:
                    selectedArchive = .S1_PSN
                case .Xbox:
                    selectedArchive = .S1_Xbox
                }
            }
        }
        .refreshable { loadLeaderboard() }
        .onAppear(perform: {
            UIRefreshControl.appearance().tintColor = .finalsWhite
        })
    }
    
    func loadLeaderboard(){
        Task{
            leaderboard = await Leaderboards.getArchivedLeaderboard(selectedArchive)
        }
    }
}

#Preview {
    LeaderboardViewV1()
}
