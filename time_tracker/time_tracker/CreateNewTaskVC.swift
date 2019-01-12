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

protocol CreateNewTaskVCDelegate {
	func taskCout(count: ProjectsList)
	func editTaskCout(count: ProjectsList)
}

class CreateNewTaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ProjectTimeVCDelegate {
	
	func reloadTime(time: TasksList) {
		let row = taskList.firstIndex(of: time)
		let indexPosition = IndexPath(row: row!, section: 0)
		lastTasks.reloadRows(at: [indexPosition], with: .automatic)
	}
	
	
	@IBOutlet weak var newTaskTextField: UITextField!
	@IBOutlet weak var lastTasks: UITableView!
	
	var tasksNameList: ProjectsList?
	var taskList = [TasksList]()
	var delegate: CreateNewTaskVCDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		lastTasks.delegate = self
		lastTasks.dataSource = self
		navigationItem.title = tasksNameList?.name
		fetchRequest()
		lastTasks.rowHeight = UITableView.automaticDimension
		self.lastTasks.estimatedRowHeight = 44
		self.lastTasks.rowHeight = UITableView.automaticDimension
		hideKeyboardWhenTappedAround()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return taskList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CreateNewTaskTVC
		let tasks = taskList[indexPath.row]
		cell.taskName.text = tasks.name
		cell.taskTime.text = countString(time: tasks.hours) + ":" + countString(time: tasks.minutes) + ":" + countString(time: tasks.seconds)
		cell.selectionStyle = .none
		return cell
	}
	
	func countString(time: Int64) -> String {
		return Int(time) > 9 ? "\(Int(time))" : "0\(Int(time))"
	}
	
	@IBAction func newTaskButton(_ sender: Any) {
		if newTaskTextField.text != "" {
			guard let tasksName = newTaskTextField.text else {return}
			CoreDataManager.shared.createNewTask(name: tasksName, project: tasksNameList!)
			fetchRequest()
			saveTaskCount()
			newTaskTextField.text = ""
			self.newTaskTextField.endEditing(true)
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToTimer", sender: self)
	}
	
	func fetchRequest() {
		guard let project = tasksNameList?.tasksList?.allObjects as? [TasksList]  else {return}
		taskList = project
		lastTasks.reloadData()
	}
	
	func saveTaskCount() {
		let context = CoreDataManager.shared.persistentContainer.viewContext
		tasksNameList?.tasksCount = "\(taskList.count)"
		do {
			try context.save()
			delegate?.taskCout(count: tasksNameList!)
		} catch {
			print(error.localizedDescription)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToTimer" {
			if let indexPath = lastTasks.indexPathForSelectedRow {
				let destionationController = segue.destination as! ProjectTimeVC
				destionationController.task = taskList[indexPath.row]
				destionationController.hrs = Int(taskList[indexPath.row].hours)
				destionationController.min = Int(taskList[indexPath.row].minutes)
				destionationController.sec = Int(taskList[indexPath.row].seconds)
				destionationController.delegate = self
			}
		}
	}
	
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		
		let delete = UITableViewRowAction(style: .destructive, title: "Удалить") { (action, indexPath) in
			// delete item at indexPath
			let tasksList = self.taskList[indexPath.row]
			
			self.taskList.remove(at: indexPath.row)
			self.lastTasks.deleteRows(at: [indexPath], with: .automatic)
			
			// delete the company from Core Data
			let context = CoreDataManager.shared.persistentContainer.viewContext
			
			context.delete(tasksList)
			self.tasksNameList?.tasksCount = "\(self.taskList.count)"
			
			do {
				try context.save()
				self.delegate?.editTaskCout(count: self.tasksNameList!)
			} catch let saveErr {
				print("Failed to delete company:", saveErr)
			}
		}
		return [delete]
	}
	
}
