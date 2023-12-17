import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            
            TextField("SEARCH PLAYERS", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
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
}

#Preview {
    ZStack{
        Color.finalsRed
        SearchBar(searchText: .constant(""))
            .foregroundColor(.accent)
    }
}