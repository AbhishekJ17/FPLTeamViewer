//
//  SquadViewBuilder.swift
//  FPLTeamViewer
//
//  Created by Admin on 30/09/26.
//

import Foundation
import SwiftUI

struct SquadViewBuilder {

    static func makeView(teamList: BootstrapResponse?, teamSummary: TeamSummary) -> PremierLeagueTeamSquadView {
        let viewModel = DefaultSquadViewModel(teamList: teamList,
                                              teamSummary: teamSummary)
        return PremierLeagueTeamSquadView(viewModel: viewModel)
    }
}
