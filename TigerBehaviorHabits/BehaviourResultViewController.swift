//
//  BehaviourResultViewController.swift
//  TigerBehaviorHabits
//
//  Created by Julien Long on 2024/10/31.
//

import UIKit

class BehaviourResultViewController: UIViewController {

    @IBOutlet weak var lblYourScore: UILabel!
    @IBOutlet weak var lblHighScore: UILabel!

    var arrExam : [QuizModel] = []
    
    //MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        Exam()
        
    }
    
    //MARK: - IBActions
  
    
    @IBAction func Done(_ sender: Any) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.setQuizHome()
        navigationController?.popToRootViewController(animated: true)
    }
    
    func Exam() {
        
        var correct:Int = 0
        var wrong:Int = 0
        for obj in arrExam {
            if obj.correctIndex == obj.selectedIndex {
                correct = correct + 1
            } else {
                wrong = wrong + 1
            }
        }
        
        lblYourScore.text = "\(correct)"
        
        let high = UserDefaults.standard.value(forKey: "BehaviourHighScore")
        if high == nil {
            UserDefaults.standard.setValue(correct, forKey: "BehaviourHighScore")
            UserDefaults.standard.synchronize()
            self.lblHighScore.text = "\(correct)"
        } else {
            
            if high as! Int > correct {
                self.lblHighScore.text = "\(correct)"
            } else {
                UserDefaults.standard.setValue(correct, forKey: "BehaviourHighScore")
                UserDefaults.standard.synchronize()
                self.lblHighScore.text = "\(high ?? 0)"
            }
            
        }
        
    }

}
