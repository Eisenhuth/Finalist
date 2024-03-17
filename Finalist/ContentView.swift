import SwiftUI

struct ContentView: View {
    @State private var selectedMode: Modes = .Live
    @State private var showingSettings = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                
                Color(selectedMode == .Live ? LiveView().theme : .finalsRed)
                    .ignoresSafeArea()
                
                VStack{
                    Text("LEADERBOARDS")
                        .font(.finalsHeader(50))
                        .frame(height: 50)
                    
                    ModeSelection(mode: $selectedMode)
                    
                    if selectedMode == .Archive { ArchiveView() }
                    else { LiveView() }
                }
            }
            .foregroundStyle(.finalsWhite)
        }
    }
}

#Preview {
    ContentView()
}
