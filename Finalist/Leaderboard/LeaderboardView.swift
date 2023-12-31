import SwiftUI
import Ospuze

struct LeaderboardView: View {
    
    @State private var leaderboard: [LeaderboardEntry]?
    @State private var selectedLive: Leaderboards.identifiers = .LiveCrossplay
    @State private var selectedArchive: Leaderboards.archives = .OpenBeta
    @State private var selectedMode: mode = .live
    @State private var searchText = ""
    @State private var showDialogue = false
    @State private var selectedEntry: LeaderboardEntry?
    
    enum mode {
        case archive
        case live
    }
        
    var body: some View {
        ZStack {
            Color.finalsRed
                .ignoresSafeArea()
            
            VStack {
                Text("LEADERBOARDS")
                    .font(.finalsHeader(50))
                
                LeaderboardSelection(selectedLive: $selectedLive, selectedArchive: $selectedArchive, selectedMode: $selectedMode)
                
                SearchBar(searchText: $searchText)
                    .foregroundStyle(.accent)
                
                Spacer()
                
                GeometryReader{gr in
                    let columns = [
                        GridItem(.fixed(gr.size.width * 0.1)), //Rank
                        //GridItem(.fixed(gr.size.width * 0.1)), //TODO: 24h
                        GridItem(.fixed(gr.size.width * 0.3)), //Name
                        GridItem(.fixed(gr.size.width * 0.3)), //Cashouts
                        GridItem(.fixed(gr.size.width * 0.15)) //Fame
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
                                    
                                    ForEach(leaderboard, id: \.r){entry in
                                        GridRow{
                                            Text(entry.r.description)
                                                .font(.finalsBodyEmphasis())
                                                .monospacedDigit()
                                            Text(entry.name)
                                                .fixedSize()
                                            Text("$\(entry.c.formatted())")
                                                .monospacedDigit()
                                            Text(entry.f.description)
                                                .monospacedDigit()
                                        }
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
                .searchable(text: $searchText)
                .font(.finalsBody(16))
            }
        }
        .foregroundStyle(.finalsWhite)
        .task { loadLeaderboard() }
        .onChange(of: selectedLive) { loadLeaderboard() }
        .onChange(of: selectedArchive) { loadLeaderboard() }
        .onChange(of: selectedMode) { loadLeaderboard() }
        .refreshable { loadLeaderboard() }
        .onAppear(perform: {
            UIRefreshControl.appearance().tintColor = .finalsWhite
        })
        .confirmationDialog("Linked Accounts", isPresented: $showDialogue, titleVisibility: .visible) {
            if let selectedEntry = selectedEntry {
                
                let platform = switch selectedLive {
                    case .LivePSN: "PSN"
                    case .LiveXbox: "Xbox"
                    case .LiveSteam: "Steam"
                    default: "Embark"
                }
                
                Button("\(platform): \(selectedEntry.name)") {
                    UIPasteboard.general.string = selectedEntry.name
                }
                
                if let steam = selectedEntry.steam {
                    if steam != "" {
                        Button("Steam: \(steam)") {
                            UIPasteboard.general.string = steam
                        }
                    }
                }
                
                if let psn = selectedEntry.psn {
                    if psn != "" {
                        Button("PSN: \(psn)") {
                            UIPasteboard.general.string = psn
                        }
                    }
                }
                
                if let xbox = selectedEntry.xbox {
                    if xbox != "" {
                        Button("Xbox: \(xbox)") {
                            UIPasteboard.general.string = xbox
                        }
                    }
                }
            }
        } message: {
            Text("select a name to copy it to the clipboard")
        }
    }
    
    func loadLeaderboard(){
        Task{
            if selectedMode == .live {
                leaderboard = await Leaderboards.getLeaderboard(selectedLive)
            } else {
                leaderboard = await Leaderboards.getArchivedLeaderboard(selectedArchive)
            }
        }
    }
}

#Preview {
    LeaderboardView()
}
