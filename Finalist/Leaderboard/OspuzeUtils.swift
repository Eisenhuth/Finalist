import Foundation
import Ospuze

func correspondingArchive(_ selection: Leaderboards.identifiers) -> Leaderboards.archives? {
    switch selection {
    case .ClosedBeta1:          .ClosedBeta1
    case .ClosedBeta2:          .ClosedBeta2
    case .OpenBeta:             .OpenBeta
    
    case .S1_Crossplay:         .S1_Crossplay
    case .S1_PSN:               .S1_PSN
    case .S1_Xbox:              .S1_Xbox
    case .S1_Steam:             .S1_Steam
    
    case .S2_Crossplay:         .S2_Crossplay
    case .S2_PSN:               .S2_PSN
    case .S2_Xbox:              .S2_Xbox
    case .S2_Steam:             .S2_Steam
        
    case .S3_Crossplay:         .S3_Crossplay
    case .S3_Worldtour:         .S3_Worldtour
        
    case .S4_Crossplay:         .S4_Crossplay
    case .S4_Worldtour:         .S4_Worldtour
    case .S4_Sponsor:           .S4_Sponsor
        
    case .S5_Crossplay:         .S5_Crossplay
    case .S5_Worldtour:         .S5_Worldtour
    case .S5_Sponsor:           .S5_Sponsor
        
    case .S6_Crossplay:         .S6_Crossplay
    case .S6_Worldtour:         .S6_Worldtour
    case .S6_Sponsor:           .S6_Sponsor
    case .S6_PowerShift:        .S6_PowerShift
    case .S6_TDM:               .S6_TDM
    case .S6_Quickcash:         .S6_Quickcash
    case .S6_TerminalAttack:    .S6_TerminalAttack
    
    case .S7_Crossplay:         nil
    case .S7_Worldtour:         nil
    case .S7_Sponsor:           nil
    case .S7_PowerShift:        nil
    case .S7_TDM:               nil
    case .S7_Quickcash:         nil
    case .S7_TerminalAttack:    nil
    }
}

func getSeasonFromIdentifier(_ identifier: Leaderboards.identifiers) -> String {
    return switch identifier {
        
    case .ClosedBeta1: "Closed Beta 1"
    case .ClosedBeta2: "Closed Beta 2"
    case .OpenBeta: "Open Beta"
    case .S1_Crossplay, .S1_PSN, .S1_Xbox, .S1_Steam:
        "Season 1"
    case .S2_Crossplay, .S2_PSN, .S2_Xbox, .S2_Steam:
        "Season 2"
    case .S3_Crossplay, .S3_Worldtour:
        "Season 3"
    case .S4_Crossplay, .S4_Worldtour, .S4_Sponsor:
        "Season 4"
    case .S5_Crossplay, .S5_Worldtour, .S5_Sponsor:
        "Season 5"
    case .S6_Crossplay, .S6_Worldtour, .S6_Sponsor, .S6_PowerShift, .S6_TDM, .S6_Quickcash, .S6_TerminalAttack:
        "Season 6"
    case .S7_Crossplay, .S7_Worldtour, .S7_Sponsor, .S7_PowerShift, .S7_TDM, .S7_Quickcash, .S7_TerminalAttack:
        "Season 7"
    }
}

func getLeaderboardsByType(_ leaderboardType: LeaderboardType) -> [Leaderboards.identifiers] {
    return switch leaderboardType {
        
    case .ranked:
        [.S1_Crossplay, .S2_Crossplay, .S3_Crossplay, .S4_Crossplay, .S5_Crossplay, .S6_Crossplay, .S7_Crossplay]
    case .worldtour:
        [.S3_Worldtour, .S4_Worldtour, .S5_Worldtour, .S6_Worldtour, .S7_Worldtour]
    case .sponsor:
        [.S4_Sponsor, .S5_Sponsor, .S6_Sponsor, .S7_Sponsor]
    case .powershift:
        [.S6_PowerShift, .S7_PowerShift]
    case .quickcash:
        [.S6_Quickcash, .S7_Quickcash]
    case .tdm:
        [.S6_TDM, .S7_TDM]
    case .terminalattack:
        [.S6_TerminalAttack, .S7_TerminalAttack]
    }
}
