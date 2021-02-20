//
//  ViewController.swift
//  PiggyBank
//
//  Created by 村井海斗 on 2021/02/05.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimation()
        
        startButton.layer.cornerRadius = 20
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.layer.borderWidth = 2.0
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
            
    }
    
    func showAnimation() {
        let animationView = AnimationView(name: "top-animation")
        animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2)
        animationView.center = self.view.center
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1

        view.addSubview(animationView)

        animationView.play()
    }

    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
}

