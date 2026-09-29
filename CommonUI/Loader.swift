//
//  Loader.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import SwiftUI

struct Loader: View {
    var body: some View {
        ProgressView {
            Text("Loading")
                .font(.caption2)
                .foregroundStyle(Color.gray)
        }
        .padding()
    }
}

#Preview {
    Loader()
}
