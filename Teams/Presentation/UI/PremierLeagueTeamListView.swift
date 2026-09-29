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
        Text("Select an item")
    }

}

#Preview {
    PremierLeagueTeamListBuilder.makeView()
}
