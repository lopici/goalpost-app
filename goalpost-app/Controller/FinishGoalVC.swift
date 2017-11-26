//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Andras on 26/11/17.
//  Copyright © 2017 Andras. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self    }

  

    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        //Pass data into Core Data
    }
}
