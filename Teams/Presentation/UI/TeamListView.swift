//
//  TeamListView.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import SwiftUI

struct TeamListView: View {

    var teamSummary: TeamSummary

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(teamSummary.team.name)
                        .font(.headline)
                    Text(teamSummary.team.shortName.uppercased())
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                }

                Spacer()
                Text("\(teamSummary.playerCount) Players")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)

                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.gray)
            }
            Divider()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    TeamListView(teamSummary: TeamSummary(team: .init(id: 1, name: "Arsenal", shortName: "Ars"), playerCount: 20))
}
