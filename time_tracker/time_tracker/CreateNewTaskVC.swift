//
//  CreateNewTaskVC.swift
//  time_tracker
//
//  Created by Pavel on 13/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CreateNewTaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ProjectTimeVCDelegate {
	
	func reloadTime(time: TasksList) {
		print(time.time)
		let row = taskList.firstIndex(of: time)
		let indexPosition = IndexPath(row: row!, section: 0)
		lastTasks.reloadRows(at: [indexPosition], with: .automatic)
	}
	
	
	@IBOutlet weak var newTaskTextField: UITextField!
	@IBOutlet weak var lastTasks: UITableView!
	
	var tasksNameList: ProjectsList?
	var taskList = [TasksList]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		lastTasks.delegate = self
		lastTasks.dataSource = self
		fetchRequest()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return taskList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		let tasks = taskList[indexPath.row]
		cell.textLabel?.text = tasks.name
		cell.detailTextLabel?.text = tasks.time
		
		return cell
	}
	
	@IBAction func newTaskButton(_ sender: Any) {
		guard let tasksName = newTaskTextField.text else {return}
		CoreDataManager.shared.createNewTask(name: tasksName, project: tasksNameList!)
		fetchRequest()
		newTaskTextField.text = ""
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToTimer", sender: self)
	}
	
	func fetchRequest() {
		guard let project = tasksNameList?.tasksList?.allObjects as? [TasksList]  else {return}
		taskList = project
		lastTasks.reloadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToTimer" {
			if let indexPath = lastTasks.indexPathForSelectedRow {
				let destionationController = segue.destination as! ProjectTimeVC
				destionationController.task = taskList[indexPath.row]
				destionationController.delegate = self
			}
		}
	}
	
}
