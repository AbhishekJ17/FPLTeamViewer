//
//  PremierLeagueTeamListView.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import SwiftUI
import SwiftData

struct PremierLeagueTeamListView: View {

    @StateObject var viewModel: DefaultPremierLeagueTeamListViewModel
    @State var selectedTeam: TeamSummary?

    init(viewModel: DefaultPremierLeagueTeamListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                if viewModel.isLoading && viewModel.teamSummary.isEmpty {
                    Loader()
                }else if !viewModel.errorMessage.isEmpty && viewModel.teamSummary.isEmpty {
                    ErrorView(error: viewModel.errorMessage)
                }else {
                    ScrollView {
                        ForEach(viewModel.teamSummary, id: \.self) { team in
                            TeamListView(teamSummary: team) {
                                selectedTeam = team
                            }
                        }
                    }
                    .refreshable {
                        viewModel.fetchTeamList()
                    }
                }
            }
            .navigationDestination(item: $selectedTeam) { team in
                SquadViewBuilder.makeView(teamList: viewModel.teamList, teamSummary: team)
            }
            .navigationTitle("Premier League Teams")
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    PremierLeagueTeamListBuilder.makeView()
}
