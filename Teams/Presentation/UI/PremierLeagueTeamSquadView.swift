//
//  PremierLeagueTeamSquadView.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import SwiftUI

struct PremierLeagueTeamSquadView: View {

    var teamSummary: TeamSummary
    var squadSections: [SquadSection] = []

    var body: some View {
        List {
            ForEach(squadSections, id: \.position) { section in
                Section(header: Text(section.position.title)
                    .font(.headline)
                    .foregroundColor(.primary)) {
                        ForEach(section.players, id: \.id) { player in
                            PlayerRowView(player: player)
                        }
                    }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(teamSummary.team.name)
    }
}

#Preview {
    PremierLeagueTeamSquadView(teamSummary: TeamSummary(team: .init(id: 1, name: "Arsenal", shortName: "Ars"), playerCount: 20))
}
