//
//  BehaviourHomeViewController.swift
//  TigerBehaviorHabits
//
//  Created by Julien Long on 2024/10/31.
//

import UIKit

class HealthHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func HArd(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthTestViewController") as! HealthTestViewController
        vc.isFromGame = "HardMode"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func MEdium(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthTestViewController") as! HealthTestViewController
        vc.isFromGame = "MediumMode"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Easy(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthTestViewController") as! HealthTestViewController
        vc.isFromGame = "EasyMode"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
