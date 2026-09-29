//
//  PremierLeagueTeamListBuilder.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import Foundation
import SwiftUI

struct PremierLeagueTeamListBuilder {

    static func makeView() -> PremierLeagueTeamListView {
        let repository: PremierLeagueTeamListRepository = DefaultPremierLeagueTeamListRepository()
        let listUseCase: PremierLeagueTeamListUseCase = DefaultPremierLeagueTeamUseCase(repository: repository)
        let viewModel = DefaultPremierLeagueTeamListViewModel(
            teamListUseCase: listUseCase)
        return PremierLeagueTeamListView(viewModel: viewModel)
    }
}
