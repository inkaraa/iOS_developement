//
//  HeroServiceModern.swift
//  heroAppRandomizer
//
//  Created by Инкара on 29.11.2025.
//

import Foundation

struct HeroServiceModern {

    func fetchHero() async throws -> HeroModel {
        let randomId = Int.random(in: 1...563)
        let urlString = "https://akabab.github.io/superhero-api/api/id/\(randomId).json"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }

        let (data, _) = try await URLSession.shared.data(from: url)
        let hero = try JSONDecoder().decode(HeroModel.self, from: data)
        return hero
    }

    func fetchImageData(from urlString: String) throws -> Data {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        return try Data(contentsOf: url)
    }
}



