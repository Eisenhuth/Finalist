import SwiftUI
import Ospuze

struct LeaderboardView: View {
    @State private var leaderboard: Leaderboard?
    @State private var searchText = ""
    @State private var showDialogue = false
    @State private var selectedEntry: LeaderboardEntry?
    @State private var selection: Leaderboards.identifiers = .S6_Crossplay
    
    var archived: Bool { correspondingArchive(selection) != nil }
    var theme: Color = .finalsRed
    var leaderboardType: LeaderboardType = .ranked
    
    var body: some View {
        ZStack{
            
            theme
                .ignoresSafeArea()
                        
            VStack{
                
                Text(leaderboardType.rawValue)
                    .textCase(.uppercase)
                    .font(.finalsHeader(50))
                    .frame(height: 50)
                
                SearchBar(searchText: $searchText).foregroundStyle(theme)
                    .tint(theme)
                
                GeometryReader{gr in
                    let columns = [
                    
                        GridItem(.fixed(gr.size.width * 0.20)), //Rank
                        GridItem(.fixed(gr.size.width * 0.45)), //Name
                        GridItem(.fixed(gr.size.width * 0.30))  //League, Cashouts, Points etc.
                    ]
                    
                    VStack{
                        LeaderboardHeader(columns: columns, leaderboardType: leaderboardType)
                        
                        Divider()
                            .frame(minHeight: 3)
                            .overlay(.finalsWhite)
                            .padding(.horizontal)
                        
                        LeaderboardRows(
                            columns: columns,
                            leaderboardType: leaderboardType,
                            leaderboard: leaderboard,
                            searchText: searchText,
                            showDialogue: $showDialogue,
                            selectedEntry: $selectedEntry
                        )
                    }
                }
                .font(.finalsBody(16))
            }
        }
        .confirmationDialog("Linked Accounts", isPresented: $showDialogue, titleVisibility: .visible) {
            if let selectedEntry = selectedEntry {
                
                Group {
                    Button("Embark: \(selectedEntry.name)") {
                        UIPasteboard.general.string = selectedEntry.name
                    }
                    
                    if !selectedEntry.steamName.isEmpty {
                        Button("Steam: \(selectedEntry.steamName)") {
                            UIPasteboard.general.string = selectedEntry.steamName
                        }
                    }
                    
                    if !selectedEntry.psnName.isEmpty {
                        Button("PSN: \(selectedEntry.psnName)") {
                            UIPasteboard.general.string = selectedEntry.psnName
                        }
                    }
                    
                    if !selectedEntry.xboxName.isEmpty {
                        Button("Xbox: \(selectedEntry.xboxName)") {
                            UIPasteboard.general.string = selectedEntry.xboxName
                        }
                    }
                }
            }
        } message: {
            Text("select a name to copy it to the clipboard")
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                SeasonPicker(selection: $selection, leaderboardType: leaderboardType)
                    .tint(.finalsWhite)
                    .fixedSize()
            }
        }
        .foregroundStyle(.finalsWhite)
        .task {
            let availableLeaderboards = getLeaderboardsByType(leaderboardType)
            
            selection = availableLeaderboards.last!
            
            loadLeaderboard()
        }
        .onChange(of: selection) { loadLeaderboard() }
    }
    
    func loadLeaderboard(){
        Task{
            if archived {
                guard let correspondingArchive = correspondingArchive(selection) else {
                    leaderboard = await Leaderboards.getLeaderboard(selection); return
                }
                leaderboard = await Leaderboards.getArchivedLeaderboard(correspondingArchive)
                
            } else {
                leaderboard = await Leaderboards.getLeaderboard(selection)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LeaderboardView()
    }
}

struct LeaderboardRow: View {
    var entry: LeaderboardEntry
    var leaderboardType: LeaderboardType
    
    var body: some View {
        GridRow{
            
            Text(entry.rank.description).monospacedDigit()
            
            PlayerName(name: entry.name, clubTag: entry.clubTag)
            
            switch leaderboardType {
            case .ranked:
                LeagueBadge(league: entry.league ?? "Diamond 1", rankScore: entry.rankScore)
            case .worldtour:
                Text("$\(entry.cashouts?.formatted() ?? "")")
            case .sponsor:
                Text(entry.fans?.formatted() ?? "")
            case .powershift, .quickcash, .tdm, .terminalattack:
                Text(entry.points?.formatted() ?? "")
            }
            
        }
    }
}

struct LeaderboardHeader: View {
    var columns: [GridItem]
    var leaderboardType: LeaderboardType
    
    var body: some View {
        LazyVGrid(columns: columns, content: {
            GridRow {
                Text("Rank")
                Text("Name")
                
                switch leaderboardType {
                case .ranked:
                    Text("League")
                case .worldtour: Text("Cashouts")
                case .sponsor: Text("Fans")
                case .powershift, .quickcash, .tdm, .terminalattack:
                    Text("Points")
                }
                
            }
        })
        .font(.finalsBodyEmphasis())
    }
}

struct LeaderboardRows: View {
    var columns: [GridItem]
    var leaderboardType: LeaderboardType
    var leaderboard: Leaderboard?
    var searchText: String
    
    @Binding var showDialogue: Bool
    @Binding var selectedEntry: LeaderboardEntry?
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, content: {
                
                let filteredEntries = searchText.isEmpty
                ? leaderboard?.entries
                : leaderboard?.entries.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
                
                if let leaderboardEntries = filteredEntries {
                    
                    ForEach(leaderboardEntries, id: \.self) { entry in
                        LeaderboardRow(entry: entry, leaderboardType: leaderboardType)
                            .lineLimit(1)
                            .onTapGesture(perform: {
                                showDialogue = true
                                selectedEntry = entry
                            })
                    }
                    
                }
            })
        }
    }
}
