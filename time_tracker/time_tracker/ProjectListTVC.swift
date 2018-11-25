//
//  ProjectListTVC.swift
//  time_tracker
//
//  Created by Pavel on 11/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import CoreData

class ProjectListTVC: UITableViewController, CreateProjectViewControllerDelegate {
	
	func addNewProject(name: ProjectsList) {
		projectListArray.append(name)
		tableView.reloadData()
	}
	
	var projectListArray = [ProjectsList]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UINib(nibName: "ProjectListTVCell", bundle: nil), forCellReuseIdentifier: "cell")
		let context = CoreDataManager.shared.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<ProjectsList>(entityName: "ProjectsList")
		do {
			projectListArray = try context.fetch(fetchRequest)
		} catch {
			print(error.localizedDescription)
		}
		if projectListArray.isEmpty {
			createProjectName()
		}
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return projectListArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProjectListTVCell
		let projects = projectListArray[indexPath.row]
		cell.projectName.text = projects.name
		cell.colorProject.backgroundColor = UIColor(red: CGFloat(projects.red), green: CGFloat(projects.green), blue: CGFloat(projects.blue), alpha: 1)
		return cell
	}
	
	@IBAction func addNewProject(_ sender: Any) {
		print("asdasd")
		createProjectName()
	}
	
	
	func createProjectName() {
		let createProjectViewController = CreateProjectViewController()
		createProjectViewController.delegate = self
		present(createProjectViewController, animated: true, completion: nil)
	}
	
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		
		let delete = UITableViewRowAction(style: .destructive, title: "Удалить") { (action, indexPath) in
			// delete item at indexPath
			self.projectListArray.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
			if self.projectListArray.isEmpty {
				self.createProjectName()
			}
		}
		
		let edit = UITableViewRowAction(style: .default, title: "Изменить") { (action, indexPath) in
			let editProjectViewController = EditProjectViewController()
			let test = self.projectListArray[indexPath.row]
//			editProjectViewController.delegate = self
//			editProjectViewController.projects = test.title
			self.present(editProjectViewController, animated: true, completion: nil)
			print("share")
		}
		
		edit.backgroundColor = UIColor.lightGray
		return [delete, edit]
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "goToAddNewTask", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToAddNewTask" {
			if let indexPath = tableView.indexPathForSelectedRow {
				let destination = segue.destination as! CreateNewTaskVC
				destination.tasksNameList = projectListArray[indexPath.row]
			}
		}
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
