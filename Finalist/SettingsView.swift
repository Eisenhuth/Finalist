import SwiftUI

struct SettingsView: View {
    @AppStorage("highlightName") private var highlightName: String = "Oscar#1234"
    @AppStorage("highlightClub") private var highlightClub: String = "OSPUZ"
    
    var body: some View {
        ZStack {
            Color.finalsRed
                .ignoresSafeArea()
            
            Form {
                Section("Highlight Name & Club Tag") {
                    TextField("Player Name", text: $highlightName, prompt: Text("Name"))
                    TextField(text: $highlightClub, prompt: Text("Club Tag")) { Text("Club Tag") }
                        .textInputAutocapitalization(.characters)
                }
                .autocorrectionDisabled()
                .tint(.finalsWhite)
                .listRowBackground(Color.finalsWhite.opacity(0.1))
                
                Section("Preview") {
                    PlayerName(name: highlightName, clubTag: highlightClub)
                    PlayerName(name: "Oscar#1234", clubTag: "EMBRK")
                    PlayerName(name: "Scotty#5678", clubTag: "OSPUZ")
                    PlayerName(name: "June#9012", clubTag: "")

                }
                .listRowBackground(Color.finalsWhite.opacity(0.1))
                
                Section("Source") {
                    Button(action: {
                        UIApplication.shared.open(URL(string: "https://github.com/Eisenhuth/Finalist")!)
                    }, label: {
                        Label { Text("Eisenhuth/Finalist") } icon: { Image("github-mark-white").resizable().scaledToFit() }
                    })
                }
            }
            .tint(.finalsRed)
            .foregroundStyle(.finalsWhite)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .textCase(.uppercase)
                        .font(.finalsHeader(50))
                        .frame(height: 50)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
