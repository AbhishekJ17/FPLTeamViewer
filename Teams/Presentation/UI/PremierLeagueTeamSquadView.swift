//
//  PremierLeagueTeamSquadView.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import SwiftUI

struct PremierLeagueTeamSquadView: View {

    var teamSummary: TeamSummary
    var body: some View {
        Text(teamSummary.team.name)
    }
}

#Preview {
    PremierLeagueTeamSquadView(teamSummary: TeamSummary(team: .init(id: 1, name: "Arsenal", shortName: "Ars"), playerCount: 20))
}
