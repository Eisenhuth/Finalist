import SwiftUI
import Ospuze

struct LiveView: View {
    @State private var leaderboard: [LeaderboardEntryV2]?
    @State private var selectedPlatform: Platforms = .Crossplay
    @State private var selectedLeaderboard: Leaderboards.idenfifiersV2 = .LiveCrossplay
    @State private var searchText = ""
    @State private var showDialogue = false
    @State private var selectedEntry: LeaderboardEntryV2?
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
                                                .frame(width: 30, height: 30)
                                            
                                            
                                        }
                                        .lineLimit(1)
                                        .onTapGesture(perform: {
                                            showDialogue = true
                                            selectedEntry = entry
                                        })
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
        .confirmationDialog("Linked Accounts", isPresented: $showDialogue, titleVisibility: .visible) {
            if let selectedEntry = selectedEntry {
                
                let platform = switch selectedPlatform {
                case .PSN: "PSN"
                case .Xbox: "Xbox"
                case .Steam: "Steam"
                default: "Embark"
                }
                
                Button("\(platform): \(selectedEntry.name)") {
                    UIPasteboard.general.string = selectedEntry.name
                }
                
                if !selectedEntry.steam.isEmpty {
                    Button("Steam: \(selectedEntry.steam)") {
                        UIPasteboard.general.string = selectedEntry.steam
                    }
                }
                
                if !selectedEntry.psn.isEmpty {
                    Button("PSN: \(selectedEntry.psn)") {
                        UIPasteboard.general.string = selectedEntry.psn
                    }
                }
                
                if !selectedEntry.xbox.isEmpty {
                    Button("Xbox: \(selectedEntry.xbox)") {
                        UIPasteboard.general.string = selectedEntry.xbox
                    }
                }
            }
        } message: {
            Text("select a name to copy it to the clipboard")
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
