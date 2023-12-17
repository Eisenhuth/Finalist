import SwiftUI
import YASU

struct LeaderboardView: View {
    
    @State private var leaderboard: [LeaderboardEntry]?
    @State private var selection = "S1"
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            Color.finalsRed
                .ignoresSafeArea()
            
            VStack {
                Text("LEADERBOARDS")
                    .font(.finalsHeader(50))
                
                LeaderboardSelection(selection: $selection)
                
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
                                    
                                    ForEach(leaderboard, id: \.name){entry in
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
        .onChange(of: selection) { loadLeaderboard() }
        .refreshable { loadLeaderboard() }
        .onAppear(perform: {
            UIRefreshControl.appearance().tintColor = .finalsWhite
        })
    }
    
    func loadLeaderboard(){
        Task{
            let leaderboardUrl = URL(string: Leaderboards.getLeaderboard(selection))!
            leaderboard = await loadData(leaderboardUrl)
        }
    }
}

#Preview {
    LeaderboardView()
}
