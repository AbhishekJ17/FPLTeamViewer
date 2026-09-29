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

    init(viewModel: DefaultPremierLeagueTeamListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                if viewModel.isLoading && viewModel.teamSummary.isEmpty {
                    Loader()
                }else {
                    ScrollView {
                        ForEach(viewModel.teamSummary, id: \.self) { team in
                            NavigationLink {
                                PremierLeagueTeamSquadView(teamSummary: team)
                                    .onAppear {
                                        debugPrint("Navigate to team: ", team)
                                    }
                            } label: {
                                TeamListView(teamSummary: team)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .navigationTitle("Premier League Teams")
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    PremierLeagueTeamListBuilder.makeView()
}
