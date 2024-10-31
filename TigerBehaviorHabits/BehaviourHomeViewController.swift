//
//  BehaviourHomeViewController.swift
//  TigerBehaviorHabits
//
//  Created by Julien Long on 2024/10/31.
//

import UIKit

class BehaviourHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickHard(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BehaviourTestViewController") as! BehaviourTestViewController
        vc.isFromGame = "HardMode"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func clickMedium(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BehaviourTestViewController") as! BehaviourTestViewController
        vc.isFromGame = "MediumMode"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickEasy(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BehaviourTestViewController") as! BehaviourTestViewController
        vc.isFromGame = "EasyMode"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
