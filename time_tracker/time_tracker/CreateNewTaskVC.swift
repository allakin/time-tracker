//
//  CreateNewTaskVC.swift
//  time_tracker
//
//  Created by Pavel on 13/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import Foundation

class CreateNewTaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ProjectTimeVCDelegate {
	
	func reloadTime(time: Time) {
//		let row = timeList.index(of: time)
//		let reloadIndexPath = IndexPath(row: row!, section: 0)
//		lastTasks.reloadRows(at: [reloadIndexPath], with: .automatic)
	}
	
	
	@IBOutlet weak var newTaskTextField: UITextField!
	@IBOutlet weak var lastTasks: UITableView!
	
	var taskList = [NewTask]()
	var timeList = [Time]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		lastTasks.delegate = self
		lastTasks.dataSource = self
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return taskList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = taskList[indexPath.row].taskName
		cell.detailTextLabel?.text = timeList[indexPath.row].timerCount
		return cell
	}
	
	@IBAction func newTaskButton(_ sender: Any) {
		guard let tasks = newTaskTextField.text else {return}
		let task2 = NewTask(taskName: tasks)
		let time = Time(timerCount: "Приступить к задаче")
		taskList.append(task2)
		timeList.append(time)
		lastTasks.reloadData()
		newTaskTextField.text = ""
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToTimer", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToTimer" {
			if let indexPath = lastTasks.indexPathForSelectedRow {
				let destionationController = segue.destination as! ProjectTimeVC
				destionationController.task = taskList[indexPath.row].taskName
				destionationController.delegate = self
			}
		}
	}
	
}
