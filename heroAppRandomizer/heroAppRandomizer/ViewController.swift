//
//  ViewController.swift
//  heroAppRandomizer
//
//  Created by Инкара on 29.11.2025.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var heroNameLabel: UILabel!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var intelligenceLabel: UILabel!
    @IBOutlet private weak var strengthLabel: UILabel!
    @IBOutlet private weak var speedLabel: UILabel!
    @IBOutlet private weak var durabilityLabel: UILabel!
    @IBOutlet private weak var powerLabel: UILabel!
    @IBOutlet private weak var combatLabel: UILabel!
    @IBOutlet private weak var publisherLabel: UILabel!
    @IBOutlet private weak var alignmentLabel: UILabel!
    @IBOutlet private weak var raceLabel: UILabel!
    @IBOutlet private weak var occupationLabel: UILabel!
    @IBOutlet private weak var randomizeButton: UIButton!

    // MARK: - Properties
    var heroService = HeroServiceModern()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        clearLabels()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor(red: 10/255, green: 30/255, blue: 64/255, alpha: 1)

        heroImageView.contentMode = .scaleAspectFit
        heroImageView.layer.shadowColor = UIColor.black.cgColor
        heroImageView.layer.shadowOpacity = 0.5
        heroImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        heroImageView.layer.shadowRadius = 10

        // Кнопка
        randomizeButton.backgroundColor = UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1)
        randomizeButton.setTitleColor(.white, for: .normal)
        randomizeButton.layer.cornerRadius = 12
        randomizeButton.layer.shadowColor = UIColor.black.cgColor
        randomizeButton.layer.shadowOpacity = 0.3
        randomizeButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        randomizeButton.layer.shadowRadius = 5
    }

    // MARK: - Actions
    @IBAction private func randomizeHeroTapped(_ sender: UIButton) {

        heroNameLabel.text = "Loading..."
        heroImageView.image = nil
        clearLabels()

        Task { @MainActor in
            do {
                let hero = try await heroService.fetchHero()
                animateAndUpdateUI(with: hero)
            } catch {
                showError(error)
            }
        }
    }

    // MARK: - Helpers
    private func animateAndUpdateUI(with hero: HeroModel) {
        // Fade-out анимация
        UIView.animate(withDuration: 0.3, animations: {
            self.heroImageView.alpha = 0
            self.heroNameLabel.alpha = 0
            self.fullNameLabel.alpha = 0
            self.intelligenceLabel.alpha = 0
            self.strengthLabel.alpha = 0
            self.speedLabel.alpha = 0
            self.durabilityLabel.alpha = 0
            self.powerLabel.alpha = 0
            self.combatLabel.alpha = 0
            self.publisherLabel.alpha = 0
            self.alignmentLabel.alpha = 0
            self.raceLabel.alpha = 0
            self.occupationLabel.alpha = 0
        }) { _ in
            // Обновляем данные
            self.heroNameLabel.text = hero.name
            self.fullNameLabel.text = "Full Name: \(hero.biography.fullName)"
            self.intelligenceLabel.text = "Intelligence: \(hero.powerstats.intelligence)"
            self.strengthLabel.text = "Strength: \(hero.powerstats.strength)"
            self.speedLabel.text = "Speed: \(hero.powerstats.speed)"
            self.durabilityLabel.text = "Durability: \(hero.powerstats.durability)"
            self.powerLabel.text = "Power: \(hero.powerstats.power)"
            self.combatLabel.text = "Combat: \(hero.powerstats.combat)"
            self.publisherLabel.text = "Publisher: \(hero.biography.publisher)"
            self.alignmentLabel.text = "Alignment: \(hero.biography.alignment)"
            self.raceLabel.text = "Race: \(hero.appearance.race ?? "Unknown")"
            self.occupationLabel.text = "Occupation: \(hero.work.occupation)"

            if let url = URL(string: hero.images.lg) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.heroImageView.image = UIImage(data: data)
                        }
                    }
                }
            }

            // Fade-in анимация
            UIView.animate(withDuration: 0.3) {
                self.heroImageView.alpha = 1
                self.heroNameLabel.alpha = 1
                self.fullNameLabel.alpha = 1
                self.intelligenceLabel.alpha = 1
                self.strengthLabel.alpha = 1
                self.speedLabel.alpha = 1
                self.durabilityLabel.alpha = 1
                self.powerLabel.alpha = 1
                self.combatLabel.alpha = 1
                self.publisherLabel.alpha = 1
                self.alignmentLabel.alpha = 1
                self.raceLabel.alpha = 1
                self.occupationLabel.alpha = 1
            }
        }
    }

    private func clearLabels() {
        fullNameLabel.text = ""
        intelligenceLabel.text = ""
        strengthLabel.text = ""
        speedLabel.text = ""
        durabilityLabel.text = ""
        powerLabel.text = ""
        combatLabel.text = ""
        publisherLabel.text = ""
        alignmentLabel.text = ""
        raceLabel.text = ""
        occupationLabel.text = ""
    }

    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

