//
//  NetworkManager.swift
//  SuperheroRandomizerApp
//
//  Created by Инкара on 06.12.2025.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case serverError(statusCode: Int)
    case decodingError
    case unknown(Error)
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseAllURL = "https://akabab.github.io/superhero-api/api/"

    // Fetch hero by id
    func fetchHero(by id: Int, completion: @escaping (Result<HeroModel, NetworkError>) -> Void) {
        let urlString = "\(baseAllURL)id/\(id).json"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL)); return
        }

        // Response on background queue to avoid main-thread decode
        AF.request(url, requestModifier: { $0.timeoutInterval = 15 })
          .validate()
          .responseData(queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let data):
                do {
                    let hero = try JSONDecoder().decode(HeroModel.self, from: data)
                    completion(.success(hero))
                } catch {
                    completion(.failure(.decodingError))
                }
            case .failure(let afError):
                if let code = response.response?.statusCode {
                    completion(.failure(.serverError(statusCode: code)))
                } else {
                    completion(.failure(.unknown(afError)))
                }
            }
          }
    }

    // Fetch list of all heroes (if you want to pick from full list)
    func fetchAllHeroes(completion: @escaping (Result<[HeroModel], NetworkError>) -> Void) {
        let urlString = "\(baseAllURL)all.json"
        guard let url = URL(string: urlString) else { completion(.failure(.invalidURL)); return }

        AF.request(url, requestModifier: { $0.timeoutInterval = 20 })
          .validate()
          .responseData(queue: .global(qos: .userInitiated)) { response in
            switch response.result {
            case .success(let data):
                do {
                    let heroes = try JSONDecoder().decode([HeroModel].self, from: data)
                    completion(.success(heroes))
                } catch {
                    completion(.failure(.decodingError))
                }
            case .failure(let afError):
                if let code = response.response?.statusCode {
                    completion(.failure(.serverError(statusCode: code)))
                } else {
                    completion(.failure(.unknown(afError)))
                }
            }
          }
    }
}
