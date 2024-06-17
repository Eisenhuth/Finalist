import SwiftUI
import Ospuze

struct LeaderboardViewV3: View {
    @State private var leaderboard: LeaderboardV3?
    @State private var searchText = ""
    @State private var showDialogue = false
    @State private var selectedEntry: LeaderboardEntryV3?
    @State private var s3selection: Leaderboards.identifiersV3 = .S3_Worldtour
    var theme: Color = .finalsDarkRed
    var seasonTitle = "SEASON 3"
    let selectedFont: Font = .finalsButtonEmphasis(35)
    let normalFont: Font = .finalsButton(30)
    
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [.finalsRed, .finalsDarkRed, .finalsDarkRed, .finalsDarkRed, .finalsDarkRed, .finalsBlack], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                        
            VStack{
                HStack {
                    Text("RANKED")
                        .onTapGesture { s3selection = .S3_Crossplay }
                        .font(s3selection == .S3_Crossplay ? selectedFont : normalFont)
                    Text("I")
                        .font(normalFont)
                    Text("WORLD TOUR")
                        .onTapGesture { s3selection = .S3_Worldtour }
                        .font(s3selection == .S3_Worldtour ? selectedFont : normalFont)
                }
                .frame(height: 35)
                
                SearchBar(searchText: $searchText).foregroundStyle(theme)
                
                GeometryReader{gr in
                    let columns = s3selection == .S3_Crossplay
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
                                if s3selection == .S3_Crossplay { Text("24h") }
                                Text("Name")
                                if s3selection == .S3_Crossplay { Text("League") }
                                if s3selection == .S3_Worldtour { Text("Cashouts") }
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
                                            
                                            if s3selection == .S3_Crossplay {
                                                Text(entry.change?.description ?? "")
                                                    .monospaced()
                                            }
                                            
                                            Text(entry.name)
                                            
                                            if s3selection == .S3_Crossplay {
                                                Image(entry.league ?? "Diamond 1")
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                            }
                                            
                                            if s3selection == .S3_Worldtour {
                                                Text("$\(entry.cashouts?.formatted() ?? "")")
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
        .onChange(of: s3selection) { loadLeaderboard() }
        .task { loadLeaderboard() }
    }
    
    func loadLeaderboard(){
        Task{
            leaderboard = await Leaderboards.getLeaderboardV3(s3selection)
        }
    }
}

#Preview {
    LeaderboardViewV3()
}
