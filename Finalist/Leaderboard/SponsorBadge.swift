import SwiftUI

struct SponsorBadge: View {
    var sponsor: String
    var fans: Int
    
    var body: some View {
        HStack {
            Image(sponsor.lowercased())
                .resizable()
                .frame(width: 20, height: 20)
                .padding(1)
                .background(sponsorBackgroundColor(for: sponsor.lowercased()))
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .foregroundStyle(.finalsWhite)
            
            Text(fans.formatted()).monospacedDigit()
        }
        .frame(height: 16)
    }
}

func sponsorBackgroundColor(for sponsor: String) -> Color {
    switch sponsor {
    case "alfa acta", "dissun", "cns", "holtow", "ospuze", "iseul-t", "engimo", "trentila":
        Color.black
    case "vaiiya":
        Color.white
    default:
        Color.gray.opacity(0.2)
    }
}

#Preview {
    
    let sponsors = ["ospuze", "iseul-t", "holtow", "cns", "vaiiya", "engimo", "dissun", "alfa acta", "trentila"]
    
    ZStack {
     
        Color.finalsRed
            .ignoresSafeArea(.all)
        
        VStack {
            ForEach(sponsors, id: \.self) {
                SponsorBadge(sponsor: $0, fans: .random(in: 10_000...99_000))
            }
        }
    }
    .preferredColorScheme(.dark)
}
