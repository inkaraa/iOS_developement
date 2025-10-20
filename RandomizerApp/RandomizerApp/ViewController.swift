//
//  ViewController.swift
//  RandomizerApp
//
//  Created by Инкара on 24.10.2025.
//

import UIKit
struct Item {
    let name: String
    let image: String
}

class ViewController: UIViewController {

    @IBOutlet weak var Icons: UIImageView!
    
    @IBOutlet weak var Label: UILabel!
    
    let items: [Item] = [
        Item(name: "Pudge A thick-skinned butcher with powerful control and immense durability. However, he lives and dies by his hooks — miss one, and the whole plan falls apart.", image: "p1"),
        Item(name: "Drow Ranger A late-game powerhouse, but fragile early on without protection. The classic glass cannon — deadly from afar, brittle up close.", image: "p2"),
        Item(name: "Io Has almost no solo potential. Without a partner, it’s just a glowing orb — adorable, yet helpless.", image: "p3"),
        Item(name: "Invoker A true strategist armed with an arsenal of spells. If your mind can handle the micro-management, you’re practically a demigod.", image: "p4"),
        Item(name: "Phantom Assassin Death cloaked in luck’s shadow. When the crit lands — the enemy ceases to exist. When it doesn’t — she might.", image: "p5"),
        Item(name: "Queen of Pain Agile, beautiful, and deadly. But she demands precision and perfect timing — one mistake, and the crown slips.", image: "p6"),
        Item(name: "Bloodseeker Fast, feral, and fueled by the pain of others. Terrifying when his prey is weakened — a predator that smells fear.", image: "p7"),
        Item(name: "Dark Willow Dangerous in skilled hands, but moody and demanding. Requires quick reflexes and a fine sense of distance.", image: "p8"),
        Item(name: "Alchemist Can grow into a monster if left undisturbed. Until then — a walking sack of gold for his enemies.", image: "p9"),
        Item(name: "Mirana Balanced in every aspect but rarely dominant. Her strength lies in versatility, not raw supremacy.", image: "p10"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        let randomItem = items.randomElement()!
        Icons.image = UIImage(named: randomItem.image)
        Label.text = randomItem.name
    }
    
}

