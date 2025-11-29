//
//  HeroModel.swift
//  heroAppRandomizer
//
//  Created by Инкара on 29.11.2025.
//

import Foundation

struct HeroModel: Decodable {
    let id: Int
    let name: String
    let biography: Biography
    let powerstats: PowerStats
    let appearance: Appearance
    let work: Work
    let images: Images

    struct Biography: Decodable {
        let fullName: String
        let publisher: String
        let alignment: String
    }

    struct PowerStats: Decodable {
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
    }

    struct Appearance: Decodable {
        let race: String?
    }

    struct Work: Decodable {
        let occupation: String
    }

    struct Images: Decodable {
        let md: String
        let lg: String
    }
}


