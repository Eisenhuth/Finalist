import SwiftUI
import Ospuze

struct LeaderboardViewV3: View {
    @State private var leaderboard: LeaderboardV3?
    @State private var searchText = ""
    @State private var showDialogue = false
    @State private var selectedEntry: LeaderboardEntryV3?
    @State private var selection: Leaderboards.identifiersV3 = .S4_Crossplay
    var archived: Bool = false
    var theme: Color = .finalsRed
    var leaderboards: [Leaderboards.identifiersV3] = [.S4_Crossplay, .S4_Worldtour, .S4_Sponsor]
    let selectedFont: Font = .finalsButtonEmphasis(35)
    let normalFont: Font = .finalsButton(30)
    
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [.finalsRed, theme, theme, theme], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                        
            VStack{
                HStack {
                    ForEach(leaderboards, id: \.self) { identifier in
                        
                        Text(getTitle(for: identifier).uppercased())
                            .onTapGesture { selection = identifier }
                            .font(selection == identifier ? selectedFont : normalFont)
                        
                        if identifier != leaderboards.last {
                            Text("I")
                                .font(normalFont)
                        }
                    }
                }
                .frame(height: 35)
                
                SearchBar(searchText: $searchText).foregroundStyle(theme)
                
                GeometryReader{gr in
                    let columns = !archived && (selection == .S4_Crossplay || selection == .S5_Crossplay || selection == .S6_Crossplay)
                    ? [
                        GridItem(.fixed(gr.size.width * 0.15)), //Rank
                        GridItem(.fixed(gr.size.width * 0.20)), //24h
                        GridItem(.fixed(gr.size.width * 0.30)), //Name
                        GridItem(.fixed(gr.size.width * 0.25))  //League
                    ] : [
                    
                        GridItem(.fixed(gr.size.width * 0.15)), //Rank
                        GridItem(.fixed(gr.size.width * 0.40)), //Name
                        GridItem(.fixed(gr.size.width * 0.30))  //Cashouts
                    ]
                    
                    VStack{
                        LazyVGrid(columns: columns, content: {
                            GridRow {
                                Text("Rank")
                                if !archived && (selection == .S4_Crossplay || selection == .S5_Crossplay || selection == .S6_Crossplay) { Text("24h") }
                                Text("Name")
                                if selection == .S3_Crossplay || selection == .S4_Crossplay || selection == .S5_Crossplay || selection == .S6_Crossplay { Text("League") }
                                if selection == .S3_Worldtour || selection == .S4_Worldtour || selection == .S5_Worldtour || selection == .S6_Worldtour { Text("Cashouts") }
//                                if selection == .S4_Sponsor { Text("Sponsor") } //TODO
                                if selection == .S4_Sponsor || selection == .S5_Sponsor || selection == .S6_Sponsor { Text("Fans") }
                                
                            }
                        })
                        .font(.finalsBodyEmphasis())
                        
                        Divider()
                            .frame(minHeight: 3)
                            .overlay(.finalsWhite)
                            .padding(.horizontal)
                        
                        ScrollView{
                            LazyVGrid(columns: columns, content: {
                                if let leaderboardEntries = searchText.isEmpty ? leaderboard?.entries : leaderboard?.entries.filter({ $0.name.lowercased().contains(searchText.lowercased()) }){
                                 
                                    ForEach(leaderboardEntries, id: \.self) { entry in
                                        GridRow{
                                            Text(entry.rank.description)
                                                .font(.finalsBodyEmphasis())
                                                .monospacedDigit()
                                            
                                            if !archived && (selection == .S4_Crossplay || selection == .S5_Crossplay || selection == .S6_Crossplay) {
                                                Text(entry.change?.description ?? "")
                                                    .monospaced()
                                            }
                                            
                                            Text(entry.name)
                                            
                                            if selection == .S3_Crossplay || selection == .S4_Crossplay || selection == .S5_Crossplay || selection == .S6_Crossplay {
                                                Image(entry.league ?? "Diamond 1")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                            }
                                            
                                            if selection == .S3_Worldtour || selection == .S4_Worldtour || selection == .S5_Worldtour || selection == .S6_Worldtour {
                                                Text("$\(entry.cashouts?.formatted() ?? "")")
                                            }
                                            
                                            if selection == .S4_Sponsor || selection == .S5_Sponsor || selection == .S6_Sponsor {
                                                Text(entry.fans?.formatted() ?? "")
                                            }
                                        }
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
                .font(.finalsBody(16))
            }
        }
        .confirmationDialog("Linked Accounts", isPresented: $showDialogue, titleVisibility: .visible) {
            if let selectedEntry = selectedEntry {
                
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
        } message: {
            Text("select a name to copy it to the clipboard")
        }
        .foregroundStyle(.finalsWhite)
        .tint(theme)
        .onChange(of: selection) { loadLeaderboard() }
        .task { selection = leaderboards[0] }
        .task { loadLeaderboard() }
    }
    
    func loadLeaderboard(){
        Task{
            if !archived {
                leaderboard = await Leaderboards.getLeaderboardV3(selection)
            } else {
                guard let correspondingArchive = correspondingArchive(selection: selection) else {
                    leaderboard = await Leaderboards.getLeaderboardV3(selection); return
                }
                leaderboard = await Leaderboards.getArchivedLeaderboardV3(correspondingArchive)
            }
        }
    }
    
    func getTitle(for selection: Leaderboards.identifiersV3) -> String {
        switch selection {
        case .S3_Crossplay, .S4_Crossplay, .S5_Crossplay, .S6_Crossplay:
            return "Ranked"
        case .S3_Worldtour, .S4_Worldtour, .S5_Worldtour, .S6_Worldtour:
            return "World Tour"
        case .S4_Sponsor, .S5_Sponsor, .S6_Sponsor:
            return "Sponsor"
        }
    }
    
    func correspondingArchive(selection: Leaderboards.identifiersV3) -> Leaderboards.archivesV3? {
        switch selection {
        case .S3_Crossplay: .S3_Crossplay
        case .S3_Worldtour: .S3_Worldtour
        
        case .S4_Crossplay: .S4_Crossplay
        case .S4_Worldtour: .S4_Worldtour
        case .S4_Sponsor:   .S4_Sponsor
        
        case .S5_Crossplay: .S5_Crossplay
        case .S5_Worldtour: .S5_Worldtour
        case .S5_Sponsor:   .S5_Sponsor
            
        case .S6_Crossplay: nil
        case .S6_Worldtour: nil
        case .S6_Sponsor:   nil
        }
    }
}

#Preview {
    LeaderboardViewV3()
}
