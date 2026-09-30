//
//  ErrorView.swift
//  FPLTeamViewer
//
//  Created by Admin on 30/09/26.
//

import SwiftUI

struct ErrorView: View {
    var error: String

    var body: some View {
        Text(error)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
    }
}

#Preview {
    ErrorView(error: "No error")
}
