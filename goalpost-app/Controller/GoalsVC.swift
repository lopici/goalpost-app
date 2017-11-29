//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Andras on 22/11/17.
//  Copyright © 2017 Andras. All rights reserved.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var goals: [Goal] = []
    
    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard  let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return
        }
        presentDetail(createGoalVC)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
       
    }

   

}

//Does not need to be an extension, just a preference as many things may go here
extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [deleteAction]
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                    
                } else {
                    tableView.isHidden = true
                }
            }
        }

    }
}

extension GoalsVC {
    func fetch(completion: (_ complete: Bool) ->()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
        goals = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint("could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let manageContext = appDelegate?.persistentContainer.viewContext else { return }
        
        manageContext.delete(goals[indexPath.row])
        
        do {
            try manageContext.save()
            print("Successfully removed goal")
        } catch {
            debugPrint("Could not remove \(error.localizedDescription)")
        }
    }
}
