//
//  PlayerRowView.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//
import SwiftUI

struct PlayerRowView: View {
    let player: Player

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(player.webName)
                    .font(.body)
                    .fontWeight(.semibold)
                Text("\(player.firstName) \(player.secondName)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("\(player.totalPoints) pts")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Text("Cost: £\(Double(player.nowCost) / 10.0)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    PlayerRowView(
        player: .init(
            id: 1,
            team: 1,
            elementType: 2,
            webName: "",
            firstName: "",
            secondName: "",
            nowCost: 1,
            totalPoints: 1
        )
    )
}
