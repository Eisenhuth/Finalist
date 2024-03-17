import SwiftUI

enum Platforms {
    case Crossplay
    case Steam
    case PSN
    case Xbox
}

struct PlatformSelection: View {
    @Binding var platform: Platforms
    let emphasis: CGFloat = 25
    let normal: CGFloat = 20
    let selectedFont: Font = .finalsButtonEmphasis(25)
    let normalFont: Font = .finalsButton(20)
    
    var body: some View {
        HStack{
            Image("Embark")
                .resizable()
                .renderingMode(.template)
                .frame(
                    width: platform == .Crossplay ? emphasis : normal,
                    height: platform == .Crossplay ? emphasis : normal
                )
                .onTapGesture { platform = .Crossplay }
            Image("Steam")
                .resizable()
                .renderingMode(.template)
                .frame(
                    width: platform == .Steam ? emphasis : normal,
                    height: platform == .Steam ? emphasis : normal
                )
                .onTapGesture { platform = .Steam }
            Text("\(Image(systemName: "playstation.logo"))")
                .onTapGesture { platform = .PSN }
                .font(platform == .PSN ? selectedFont : normalFont)
            Text("\(Image(systemName: "xbox.logo"))")
                .onTapGesture { platform = .Xbox }
                .font(platform == .Xbox ? selectedFont : normalFont)
        }
        .frame(height: 30)
    }
}

#Preview {
    PlatformSelection(platform: .constant(.Crossplay))
}
