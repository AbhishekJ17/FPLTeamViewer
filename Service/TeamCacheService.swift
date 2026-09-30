//
//  TeamCacheService.swift
//  FPLTeamViewer
//
//  Created by Admin on 30/09/26.
//

import Foundation

protocol TeamCacheServiceProtocol {
    func save(_ data: [TeamSummary])
    func load() -> [TeamSummary]?
}

final class TeamCacheService: TeamCacheServiceProtocol {
    private let fileName = "team_summary_cache.json"

    private var fileURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(fileName)
    }

    func save(_ data: [TeamSummary]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let encoder = JSONEncoder()
                let encodedData = try encoder.encode(data)
                try encodedData.write(to: self.fileURL, options: [.atomic, .completeFileProtectionUnlessOpen])
            } catch {
                debugPrint("Failed to cache team list: \(error.localizedDescription)")
            }
        }
    }

    func load() -> [TeamSummary]? {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return nil }
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let decodedTeams = try decoder.decode([TeamSummary].self, from: data)
            return decodedTeams
        } catch {
            debugPrint("Failed to load cached team list: \(error.localizedDescription)")
            return nil
        }
    }
}
