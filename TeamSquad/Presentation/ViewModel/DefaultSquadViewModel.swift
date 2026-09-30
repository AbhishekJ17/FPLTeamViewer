//
//  DefaultSquadViewModel.swift
//  FPLTeamViewer
//
//  Created by Admin on 30/09/26.
//
import SwiftUI
import Combine

protocol SquadViewModelInput {
    var teamList: BootstrapResponse? { get set }
    var searchText: String { get set }
    var isSearchPresented: Bool { get set }
}

protocol SquadViewModelOutput {
    var errorMessage: String { get set }
    var isLoading: Bool { get set }
    var teamSummary: TeamSummary { get set }
    var squadSections: [SquadSection] { get set }
    var teamName: String { get }
}

typealias SquadViewModel = SquadViewModelInput & SquadViewModelOutput

final class DefaultSquadViewModel: SquadViewModel, ObservableObject {

    var teamList: BootstrapResponse?
    private var allPlayers: [Player] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var searchText: String = "" {
        didSet {
            updateSections()
        }
    }
    @Published var isSearchPresented: Bool = false {
        didSet {
            if !isSearchPresented {
                searchText = ""
            }
        }
    }
    var teamSummary: TeamSummary
    @Published var squadSections: [SquadSection] = []
    var teamName: String {
        teamSummary.team.name
    }

    init(teamList: BootstrapResponse? = nil, teamSummary: TeamSummary) {
        self.teamList = teamList
        self.teamSummary = teamSummary
        getSquadForSelectedTeam()
    }

    private func getSquadForSelectedTeam() {
        if let teamList {
            self.allPlayers = teamList.players(forTeam: teamSummary.id)
            self.squadSections = SquadBuilder.sections(from: allPlayers)
        }else {
            errorMessage = "There is no squad"
        }
    }

    private func updateSections() {
        if searchText.isEmpty {
            squadSections = SquadBuilder.sections(from: allPlayers, query: "")
        }else {
            squadSections = SquadBuilder.sections(from: allPlayers, query: searchText)
        }
    }
}

