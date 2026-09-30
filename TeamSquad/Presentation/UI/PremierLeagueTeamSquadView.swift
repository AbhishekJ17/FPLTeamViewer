//
//  PremierLeagueTeamSquadView.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import SwiftUI

struct PremierLeagueTeamSquadView: View {

    @StateObject var viewModel: DefaultSquadViewModel

    init(viewModel: DefaultSquadViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List {
            ForEach(viewModel.squadSections, id: \.position) { section in
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
        .navigationTitle(viewModel.teamName)
        .searchable(
            text: $viewModel.searchText,
            isPresented: $viewModel.isSearchPresented,
            placement: .navigationBarDrawer,
            prompt: "Search player in squad")
    }
}

#Preview {
    SquadViewBuilder
        .makeView(teamList: nil,
                  teamSummary: .init(team: .init(id: 1, name: "Arsenal", shortName: "Ars"), playerCount: 1))
}
