import Foundation
import SwiftUI

public extension Font {
    static func finalsHeader(_ size: CGFloat = 20)          -> Font {.custom("SairaExtraCondensed-ExtraBoldItalic", size: size)}
    static func finalsSubheader(_ size: CGFloat = 20)       -> Font {.custom("SairaExtraCondensed-ExtraBoldItalic", size: size)}
    static func finalsBody(_ size: CGFloat = 20)            -> Font {.custom("SairaCondensed-Medium", size: size)}
    static func finalsBodyEmphasis(_ size: CGFloat = 20)    -> Font {.custom("SairaCondensed-Bold", size: size)}
    static func finalsButton(_ size: CGFloat = 20)          -> Font {.custom("SairaExtraCondensed-Italic", size: size)}
    static func finalsButtonEmphasis(_ size: CGFloat = 20)  -> Font {.custom("SairaExtraCondensed-SemiBoldItalic", size: size)}
}
