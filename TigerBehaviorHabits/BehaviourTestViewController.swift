//
//  BehaviourTestViewController.swift
//  TigerBehaviorHabits
//
//  Created by Julien Long on 2024/10/31.
//

import UIKit

class BehaviourTestViewController: UIViewController {

    @IBOutlet weak var btnFour: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblQuestionCount: UILabel!
    @IBOutlet weak var btnThree: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnONe: UIButton!
    @IBOutlet weak var lblQuestion: UILabel!
    
    var isSelected:Bool = false
    var isBookmark:Bool = false
    
    var arrQuesList : [QuizModel] = []
    var arrExam : [QuizModel] = []
    var currentQue : QuizModel = QuizModel()
    
    var isFromGame = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        if isFromGame == "HardMode"{
            loadQuestionFile(filename: "BHard")
        }else if isFromGame == "MediumMode"{
            loadQuestionFile(filename: "BMedium")
        }else{
            loadQuestionFile(filename: "BEasy")
        }
        
    }
    
    //MARK: - Function
    
    func loadQuestion()
    
    {
        
        lblQuestionCount.text = "Question \(arrExam.count + 1) of 10"
        currentQue = arrQuesList[arrExam.count]
        
        lblQuestion.text = currentQue.question
        btnONe.setTitle(currentQue.options[0], for: .normal)
        btnTwo.setTitle(currentQue.options[1], for: .normal)
        btnThree.setTitle(currentQue.options[2], for: .normal)
        btnFour.setTitle(currentQue.options[3], for: .normal)
        
        
        refreseAns()
    }
    
    func setupUI() {
        
        btnONe.backgroundColor = UIColor.init(named: "theme_color")
        btnTwo.backgroundColor = UIColor.init(named: "theme_color")
        btnThree.backgroundColor = UIColor.init(named: "theme_color")
        btnFour.backgroundColor = UIColor.init(named: "theme_color")
        
        
        loadQuestion()
        
    }
    
    func refreseAns()
    {
        btnONe.backgroundColor = UIColor.init(named: "theme_color")
        btnTwo.backgroundColor = UIColor.init(named: "theme_color")
        btnThree.backgroundColor = UIColor.init(named: "theme_color")
        btnFour.backgroundColor = UIColor.init(named: "theme_color")
        isSelected = false
        btnNext.alpha = 0.5
        btnNext.isEnabled = false
    }
    
    func loadQuestionFile(filename fileName: String)
    {
        let url = UIViewController.quziUrl(withName: fileName)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            
            let arrList = json["questions"] as! NSArray
            for list in arrList
            {
                arrQuesList.append(QuizModel.init(dict: list as! NSDictionary))
            }
            debugPrint("TOTAL QK QUE: \(arrQuesList.count)")
            setupUI()
        }
        catch
        {
            debugPrint("error:\(error)")
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func OptionFour(_ sender: Any) {
        if isSelected == false {
            isSelected = true
            btnNext.alpha = 1.0
            btnNext.isEnabled = true
            
            currentQue.selectedIndex = 3
            if currentQue.correctIndex == 3 {
                btnFour.backgroundColor = UIColor.green
            } else {
                btnFour.backgroundColor = UIColor.red
                if currentQue.correctIndex == 0 {
                    btnONe.backgroundColor = UIColor.green
                } else if currentQue.correctIndex == 1 {
                    btnTwo.backgroundColor = UIColor.green
                } else if currentQue.correctIndex == 2 {
                    btnThree.backgroundColor = UIColor.green
                }
            }
        }
    }
    
    @IBAction func OptionThree(_ sender: Any) {
        if isSelected == false {
            isSelected = true
            btnNext.alpha = 1.0
            btnNext.isEnabled = true
            currentQue.selectedIndex = 2
            if currentQue.correctIndex == 2 {
                btnThree.backgroundColor = UIColor.green
            } else {
                btnThree.backgroundColor = UIColor.red
                if currentQue.correctIndex == 0 {
                    btnONe.backgroundColor = UIColor.green
                } else if currentQue.correctIndex == 1 {
                    btnTwo.backgroundColor = UIColor.green
                } else if currentQue.correctIndex == 3 {
                    btnFour.backgroundColor = UIColor.green
                }
            }
            
        }
    }
    
    @IBAction func OptionTwo(_ sender: Any) {
        
        if isSelected == false {
            isSelected = true
            btnNext.alpha = 1.0
            btnNext.isEnabled = true
            
            currentQue.selectedIndex = 1
            if currentQue.correctIndex == 1 {
                btnTwo.backgroundColor = UIColor.green
            } else {
                btnTwo.backgroundColor = UIColor.red
                if currentQue.correctIndex == 0 {
                    btnONe.backgroundColor = UIColor.green
                } else if currentQue.correctIndex == 2 {
                    btnThree.backgroundColor = UIColor.green
                } else if currentQue.correctIndex == 3 {
                    btnFour.backgroundColor = UIColor.green
                }
            }
            
        }
    }
    @IBAction func OptionOne(_ sender: Any) {
        if isSelected == false {
            isSelected = true
            btnNext.alpha = 1.0
            btnNext.isEnabled = true
            
            currentQue.selectedIndex = 0
            if currentQue.correctIndex == 0 {
                btnONe.backgroundColor = UIColor.green
            } else {
                btnONe.backgroundColor = UIColor.red
                if currentQue.correctIndex == 1 {
                    btnTwo.backgroundColor = UIColor.green
                } else if currentQue.correctIndex == 2 {
                    btnThree.backgroundColor = UIColor.green
                } else if currentQue.correctIndex == 3 {
                    btnFour.backgroundColor = UIColor.green
                }
            }
            
        }
    }
    @IBAction func Next(_ sender: Any) {
        arrExam.append(currentQue)
        if arrExam.count < 10
        {
            loadQuestion()
        }
        else
        {
            print("EXAM COMPLETE")
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "BehaviourResultViewController") as! BehaviourResultViewController
            VC.arrExam = arrExam
            
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }

}
