import SwiftUI

struct LeagueBadge: View {
    var league: String
    var rankScore: Int?
    
    var body: some View {
        HStack {
            Image(league)
                .resizable()
                .frame(width: 20, height: 20)
            if let rankScore { Text(rankScore.formatted()).monospacedDigit() }
        }
        .frame(height: 16)
    }
}

#Preview {
    LeagueBadge(league: "Diamond 1", rankScore: 90_000)
}
