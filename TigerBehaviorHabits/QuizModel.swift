//
//  QuizModel.swift
//  TigerBehaviorHabits
//
//  Created by Julien Long on 2024/10/31.
//

import UIKit

class QuizModel: NSObject {
    
    var question: String = ""
    var options: [String] = []
    var correctIndex: Int = -1
    var selectedIndex: Int = -1

    override init() {
        super.init()
    }
    
    init(dict: NSDictionary) {
        super.init()
        if let question = dict["question"] as? String {
            self.question = question
        }
        if let options = dict["options"] as? [String] {
            self.options = options
        }
        if let correctIndex = dict["correct_answer_index"] as? Int {
            self.correctIndex = correctIndex
        }
    }
}
