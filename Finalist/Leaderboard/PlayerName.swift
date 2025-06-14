import SwiftUI

struct PlayerName: View {
    var name: String
    var clubTag: String?
    
    var body: some View {
        let split = name.split(separator: "#")
        let name = split.first ?? ""
        let number = split.last ?? ""

        HStack(spacing: 2) {
            if let clubTag {
                if !clubTag.isEmpty{
                    Text(clubTag)
                        .font(.finalsBody(10))
                        .frame(width: 35)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                } else {
                    Text("")
                        .frame(width: 35)
                }
            }
            
            Text(name).font(.finalsBodyEmphasis())+Text("#\(number)").foregroundStyle(.secondary)
                .font(.finalsBody(12))
            
            Spacer()
        }
        .font(.finalsBody(16))
        .lineLimit(1)
    }
}

#Preview {
    PlayerName(name: "Oscar#1234", clubTag: "ABCDE")
    PlayerName(name: "Oscar#1234", clubTag: "")
    PlayerName(name: "Oscar#1234", clubTag: "ABC")


}
