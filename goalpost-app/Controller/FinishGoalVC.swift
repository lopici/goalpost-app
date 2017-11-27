//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Andras on 26/11/17.
//  Copyright © 2017 Andras. All rights reserved.
//

import UIKit
import CoreData

//This can be used everywhere as it is outside of the class
let appDelegate =  UIApplication.shared.delegate as? AppDelegate

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
        pointsTextField.delegate = self
        
        
    }

  

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        //Pass data into Core Data
        if pointsTextField.text != "" {
        self.save { (complete) in
            dismiss(animated: true, completion: nil)//dismiss to main viewcontroller
            }
        }
     }
    
    func save(completion: (_ finished: Bool) ->()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
        try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
}
