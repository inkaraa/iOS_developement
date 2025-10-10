//
//  ViewController.swift
//  DiceeApp
//
//  Created by Инкара on 10.10.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rightDice: UIImageView!
    @IBOutlet weak var leftDice: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let elements: [UIImageView] = [leftDice, rightDice]
        for ImageView in elements {
            let random = Int.random(in: 1...6)
            let image = UIImage(named: "cubic\(random)")
            shake(ImageView)
            ImageView.image = image
        }
       
    }
    private func shake(_ view: UIImageView){
        let random = Double.random(in: -0.4...0.4)
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.duration = Double.random(in: 0.5...0.8)
        animation.values = [-random,random,-random,random,-random,random,-random/2,random/2,0]
        view.layer.add(animation,forKey: "shake")
    }
    
}

