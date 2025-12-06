//
//  ViewController.swift
//  SuperheroRandomizerApp
//
//  Created by Инкара on 06.12.2025.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    // MARK: - IBOutlets (подключить в storyboard)
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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    private let network = NetworkManager.shared
    private var currentHeroID: Int?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        restoreLastHeroIfNeeded()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 10/255, green: 30/255, blue: 64/255, alpha: 1) // dark blue
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.layer.cornerRadius = 12
        heroImageView.layer.shadowColor = UIColor.black.cgColor
        heroImageView.layer.shadowOpacity = 0.4
        heroImageView.layer.shadowRadius = 8
        heroImageView.layer.shadowOffset = CGSize(width: 0, height: 4)

        // Button style
        randomizeButton.layer.cornerRadius = 12
        randomizeButton.backgroundColor = UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1) // #00BFFF
        randomizeButton.setTitleColor(.white, for: .normal)
        randomizeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        randomizeButton.layer.shadowColor = UIColor.black.cgColor
        randomizeButton.layer.shadowOpacity = 0.25
        randomizeButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        randomizeButton.layer.shadowRadius = 6

        activityIndicator.hidesWhenStopped = true
        styleLabels()
    }

    private func styleLabels() {
        heroNameLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        heroNameLabel.textColor = .white

        let attributeLabels: [UILabel] = [
            fullNameLabel, intelligenceLabel, strengthLabel, speedLabel,
            durabilityLabel, powerLabel, combatLabel, publisherLabel,
            alignmentLabel, raceLabel, occupationLabel
        ]
        for lbl in attributeLabels {
            lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            lbl.textColor = UIColor(white: 0.95, alpha: 1)
        }
    }

    // MARK: - Restore / Persistence
    private func restoreLastHeroIfNeeded() {
        if let lastID = Persistence.loadLastHeroID() {
            // show placeholder and load hero by ID
            loadHero(id: lastID, animated: false)
        } else {
            // no saved hero — optionally fetch random immediately or wait for user
            // we'll do nothing; user taps Randomize
        }
    }

    // MARK: - Loading
    @IBAction private func randomizeTapped(_ sender: UIButton) {
        // choose random id in range (1..563)
        let randomId = Int.random(in: 1...563)
        loadHero(id: randomId, animated: true)
    }

    private func loadHero(id: Int, animated: Bool) {
        startLoadingUI()
        network.fetchHero(by: id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.stopLoadingUI()
            }
            switch result {
            case .success(let hero):
                // save id
                Persistence.saveLastHeroID(hero.id)
                self.currentHeroID = hero.id

                // Update UI on main thread with animation
                DispatchQueue.main.async {
                    if animated {
                        self.animateAndSet(hero: hero)
                    } else {
                        self.setHeroDirect(hero: hero)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showNetworkError(error)
                }
            }
        }
    }

    private func startLoadingUI() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.randomizeButton.isEnabled = false
            self.randomizeButton.alpha = 0.6
        }
    }

    private func stopLoadingUI() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.randomizeButton.isEnabled = true
            self.randomizeButton.alpha = 1
        }
    }

    // MARK: - UI population (no animation)
    private func setHeroDirect(hero: HeroModel) {
        heroNameLabel.text = hero.name
        fullNameLabel.text = "Full name: \(hero.biography.fullName ?? "—")"
        intelligenceLabel.text = "Intelligence: \(hero.powerstats.intelligence?.description ?? "—")"
        strengthLabel.text = "Strength: \(hero.powerstats.strength?.description ?? "—")"
        speedLabel.text = "Speed: \(hero.powerstats.speed?.description ?? "—")"
        durabilityLabel.text = "Durability: \(hero.powerstats.durability?.description ?? "—")"
        powerLabel.text = "Power: \(hero.powerstats.power?.description ?? "—")"
        combatLabel.text = "Combat: \(hero.powerstats.combat?.description ?? "—")"
        publisherLabel.text = "Publisher: \(hero.biography.publisher ?? "—")"
        alignmentLabel.text = "Alignment: \(hero.biography.alignment ?? "—")"
        raceLabel.text = "Race: \(hero.appearance.race ?? "—")"
        occupationLabel.text = "Occupation: \(hero.work.occupation ?? "—")"

        // image with Kingfisher (safe)
        if let urlStr = hero.images.lg ?? hero.images.md ?? hero.images.sm, let url = URL(string: urlStr) {
            heroImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        } else {
            heroImageView.image = UIImage(systemName: "photo")
        }
    }

    // MARK: - Animated update
    private func animateAndSet(hero: HeroModel) {
        // fade out
        UIView.animate(withDuration: 0.22, animations: {
            self.heroImageView.alpha = 0
            self.heroNameLabel.alpha = 0
            // hide attribute labels
            [self.fullNameLabel, self.intelligenceLabel, self.strengthLabel,
             self.speedLabel, self.durabilityLabel, self.powerLabel,
             self.combatLabel, self.publisherLabel, self.alignmentLabel,
             self.raceLabel, self.occupationLabel].forEach { $0?.alpha = 0 }
        }) { _ in
            self.setHeroDirect(hero: hero)
            // fade in
            UIView.animate(withDuration: 0.28) {
                self.heroImageView.alpha = 1
                self.heroNameLabel.alpha = 1
                [self.fullNameLabel, self.intelligenceLabel, self.strengthLabel,
                 self.speedLabel, self.durabilityLabel, self.powerLabel,
                 self.combatLabel, self.publisherLabel, self.alignmentLabel,
                 self.raceLabel, self.occupationLabel].forEach { $0?.alpha = 1 }
            }
        }
    }

    // MARK: - Errors
    private func showNetworkError(_ error: NetworkError) {
        var message = ""
        switch error {
        case .invalidURL: message = "Invalid URL."
        case .serverError(let code): message = "Server error: \(code)."
        case .decodingError: message = "Data parsing error."
        case .unknown(let e): message = "Error: \(e.localizedDescription)"
        }
        showAlert(title: "Network error", message: message)
    }

    private func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(a, animated: true)
        }
    }
}

