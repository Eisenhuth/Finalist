import SwiftUI

struct SettingsView: View {
    @AppStorage("highlightName") private var highlightName: String = "Oscar#1234"
    @AppStorage("highlightClub") private var highlightClub: String = "OSPUZ"
    
    var body: some View {
        
            Form {
                Section("Highlight Name & Club Tag") {
                    TextField("Player Name", text: $highlightName, prompt: Text("Name"))
                    TextField(text: $highlightClub, prompt: Text("Club Tag")) { Text("Club Tag") }
                        .textInputAutocapitalization(.characters)
                }
                .autocorrectionDisabled()
                .finalsSectionStyling()
                
                Section("Preview") {
                    PlayerName(name: highlightName, clubTag: highlightClub)
                    PlayerName(name: "Oscar#1234", clubTag: "EMBRK")
                    PlayerName(name: "Scotty#5678", clubTag: "OSPUZ")
                    PlayerName(name: "June#9012", clubTag: "")
                }
                .finalsSectionStyling()
                
                Section("Source / Data") {
                    Button(action: {
                        UIApplication.shared.open(URL(string: "https://github.com/Eisenhuth/Finalist")!)
                    }, label: { GitHubLabel(text: "Eisenhuth/Finalist") })
                    
                    Button(action: {
                        UIApplication.shared.open(URL(string: "https://github.com/leonlarsson/the-finals-api")!)
                    }, label: { GitHubLabel(text: "leonlarsson/the-finals-api") })
                }
            }
            .finalsStyling()
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

struct GitHubLabel: View {
    var text: String
    
    var body: some View {
        Label {
            Text(text)
                .textCase(.none)
        } icon: {
            Image("github-mark-white")
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
