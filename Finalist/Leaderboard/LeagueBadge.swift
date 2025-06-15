import SwiftUI

struct LeagueBadge: View {
    var league: String
    var rankScore: Int?
    
    var body: some View {
        HStack {
            Image(league)
                .resizable()
                .frame(width: 30, height: 30)
            if let rankScore { Text(rankScore.formatted()).font(.finalsBody()) }
        }
        .frame(height: 25)
    }
}

#Preview {
    LeagueBadge(league: "Diamond 1", rankScore: 90_000)
}
