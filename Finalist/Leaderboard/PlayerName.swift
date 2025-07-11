import SwiftUI

struct PlayerName: View {
    @AppStorage("highlightName") private var highlightName: String = "Oscar#1234"
    @AppStorage("highlightClub") private var highlightClub: String = "OSPUZ"
    
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
                        .background(clubTag == highlightClub ? .finalsYellow.opacity(0.4) : Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(clubTag == highlightClub ? .finalsYellow.opacity(0.8) : Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .foregroundStyle(clubTag == highlightClub ? .finalsYellow : .finalsWhite)
                } else {
                    Text("")
                        .frame(width: 35)
                }
            }
            
            Text(name)
                .foregroundStyle(self.name == highlightName ? .finalsYellow : .finalsWhite)
                .font(.finalsBodyEmphasis())+Text("#\(number)").foregroundStyle(.secondary)
                .font(.finalsBody(12))
            
            Spacer()
        }
        .lineLimit(1)
    }
}

#Preview {
    ZStack {
        Color.finalsRed
            .ignoresSafeArea()
        
        VStack {
            PlayerName(name: "Oscar#1234", clubTag: "ABCDE")
            PlayerName(name: "Matt#1234", clubTag: "EMBRK")
            PlayerName(name: "Peter#1234", clubTag: "")
            PlayerName(name: "Oscar#1234", clubTag: "ABC")
        }
    }

}
