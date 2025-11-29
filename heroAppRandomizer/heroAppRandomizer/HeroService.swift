//
//  HeroService.swift
//  heroAppRandomizer
//
//  Created by Инкара on 29.11.2025.
//

import Foundation

protocol HeroServiceDelegate {
    func onHeroDidUpdate(model: HeroModel, imageData: Data)
}

struct HeroService {

    var delegate: HeroServiceDelegate?

    func fetchHeroes(randomId: Int) {
        let urlString = "https://akabab.github.io/superhero-api/api/id/\(randomId).json"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else { return }

            do {
                let model = try JSONDecoder().decode(HeroModel.self, from: data)

                if let imageUrl = URL(string: model.images.md) {
                    let imageData = try Data(contentsOf: imageUrl)
                    DispatchQueue.main.async {
                        delegate?.onHeroDidUpdate(model: model, imageData: imageData)
                    }
                }
            } catch {
                print("Parsing error: \(error)")
            }
        }
        task.resume()
    }
}


