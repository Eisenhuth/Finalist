import Foundation

struct LeaderboardEntry: Codable {
    let r: Int //Rank
    let name: String //EmbarkID
    let f: Int //Fame
    let of: Int
    let or: Int
    let c: Int //Cashout
    let steam: String?
    let xbox: String?
    let psn: String?
}
