//
//  FPLTeamViewerApp.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import SwiftUI
import SwiftData

@main
struct FPLTeamViewerApp: App {

    var body: some Scene {
        WindowGroup {
            PremierLeagueTeamListBuilder.makeView()
        }
    }
}
