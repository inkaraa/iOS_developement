//
//  HeroModel.swift
//  SuperheroRandomizerApp
//
//  Created by Инкара on 06.12.2025.
//

import Foundation

struct HeroModel: Decodable {
    let id: Int
    let name: String
    let slug: String?
    let powerstats: PowerStats
    let biography: Biography
    let appearance: Appearance
    let work: Work
    let connections: Connections?
    let images: HeroImages

    struct PowerStats: Decodable {
        let intelligence: Int?
        let strength: Int?
        let speed: Int?
        let durability: Int?
        let power: Int?
        let combat: Int?
    }

    struct Biography: Decodable {
        // JSON uses "fullName", "placeOfBirth", "publisher", "alignment"
        let fullName: String?
        let placeOfBirth: String?
        let firstAppearance: String?
        let publisher: String?
        let alignment: String?
    }

    struct Appearance: Decodable {
        let gender: String?
        let race: String?
        let height: [String]?
        let weight: [String]?
        let eyeColor: String?
        let hairColor: String?
    }

    struct Work: Decodable {
        let occupation: String?
        let base: String?
    }

    struct Connections: Decodable {
        let groupAffiliation: String?
        let relatives: String?
    }

    struct HeroImages: Decodable {
        let xs: String?
        let sm: String?
        let md: String?
        let lg: String?
    }
}
