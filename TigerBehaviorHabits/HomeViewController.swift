//
//  HomeViewController.swift
//  TigerBehaviorHabits
//
//  Created by Julien Long on 2024/10/31.
//

import UIKit
import StoreKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func Behaviour(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BehaviourHomeViewController") as! BehaviourHomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Habit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthHomeViewController") as! HealthHomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Share(_ sender: Any) {
        let objectsToShare = ["TigerBehaviorHabits"]
        let activityVController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVController.popoverPresentationController?.sourceView = self.view
        activityVController.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVController, animated: true, completion: nil)
    }
    
    @IBAction func Rate(_ sender: Any) {
        SKStoreReviewController.requestReview()
    }

    @IBAction func showPrivacyPolicyAction(_ sender: Any) {
        
    }
}
