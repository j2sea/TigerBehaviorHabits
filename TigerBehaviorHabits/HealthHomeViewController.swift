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
    

    @IBAction func clickHardAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthTestViewController") as! HealthTestViewController
        vc.isFromGame = "HardMode"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func clickMediumAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthTestViewController") as! HealthTestViewController
        vc.isFromGame = "MediumMode"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickEasyAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthTestViewController") as! HealthTestViewController
        vc.isFromGame = "EasyMode"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
