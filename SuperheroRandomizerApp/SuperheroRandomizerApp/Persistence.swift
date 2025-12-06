//
//  Persistence.swift
//  SuperheroRandomizerApp
//
//  Created by Инкара on 06.12.2025.
//

import Foundation

enum Persistence {
    private static let lastHeroIDKey = "lastHeroID_v1"

    static func saveLastHeroID(_ id: Int) {
        UserDefaults.standard.set(id, forKey: lastHeroIDKey)
    }

    static func loadLastHeroID() -> Int? {
        let id = UserDefaults.standard.integer(forKey: lastHeroIDKey)
        return UserDefaults.standard.object(forKey: lastHeroIDKey) != nil ? id : nil
    }

    static func clearLastHero() {
        UserDefaults.standard.removeObject(forKey: lastHeroIDKey)
    }
}
