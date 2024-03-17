import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            
            TextField("", text: $searchText, prompt: Text("SEARCH PLAYERS").foregroundStyle(.black.opacity(0.25)))
                .padding(7)
                .padding(.horizontal, 25)
                .background(.finalsWhite)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture { self.isEditing = true }
                .font(.finalsBody())
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.searchText = ""
                    dismissKeyboard()
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
    }
    
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ZStack{
        Color.finalsRed
        SearchBar(searchText: .constant(""))
            .foregroundColor(.accent)
    }
}
