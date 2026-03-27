import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            
            TextField("", text: $searchText, prompt: Text("SEARCH PLAYERS").foregroundStyle(.black.opacity(0.25)))
                .padding(7)
                .padding(.horizontal, 25)
                .background(.finalsWhite)
                .cornerRadius(8)
                .overlay(alignment: .leading) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                        .allowsHitTesting(false)
                }
                .overlay(alignment: .trailing) {
                    if isEditing && !searchText.isEmpty {
                        Button(action: { self.searchText = "" }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .font(.finalsBody())
                .autocorrectionDisabled()
                .focused($isFocused)
                .onChange(of: isFocused) {
                    self.isEditing = isFocused
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.searchText = ""
                    self.isFocused = false
                }) {
                    Text("Cancel")
                        .font(.finalsButtonEmphasis())
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .buttonStyle(.plain)
                .foregroundStyle(.finalsWhite)
                .backgroundStyle(.finalsWhite)
            }
        }
        .tint(.finalsRed)
        .foregroundStyle(.finalsRed)
    }
    
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
        .finalsStyling()
}
