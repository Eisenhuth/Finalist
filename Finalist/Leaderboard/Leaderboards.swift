import Foundation

struct Leaderboards {
    static let CB1 = "https://embark-discovery-leaderboard.storage.googleapis.com/leaderboard-beta-1.json"
    static let CB2 = "https://embark-discovery-leaderboard.storage.googleapis.com/leaderboard.json"
    static let OB = "https://storage.googleapis.com/embark-discovery-leaderboard/leaderboard-crossplay.json"
    static let S1 = "https://storage.googleapis.com/embark-discovery-leaderboard/leaderboard-crossplay-discovery-live.json"
    
    static func getLeaderboard(_ identifier: String) -> String {
        switch identifier {
        case "CB1":
            return CB1
        case "CB2":
            return CB2
        case "OB":
            return OB
        case "S1":
            return S1
        default:
            return S1
        }
    }
}
