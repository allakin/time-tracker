//
//  ProjectListTVC.swift
//  time_tracker
//
//  Created by Pavel on 11/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class ProjectListTVC: UITableViewController, CreateProjectViewControllerDelegate, EditProjectViewControllerDelegate {
	
	func editProject(name: Project) {
		print(name)
	}
	
	func addNewProject(name: Project) {
		projectList.append(name)
		tableView.reloadData()
	}
	
	var projectList = [Project]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.register(UINib(nibName: "ProjectListTVCell", bundle: nil), forCellReuseIdentifier: "cell")
		if projectList.isEmpty {
			createProjectName()
		}
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return projectList.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProjectListTVCell
		let projects = projectList[indexPath.row]
		cell.projectName.text = projects.title
		cell.colorProject.backgroundColor = UIColor(red: CGFloat(projects.red), green: CGFloat(projects.green), blue: CGFloat(projects.blue), alpha: CGFloat(projects.alpha))
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
			self.projectList.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
		
		let edit = UITableViewRowAction(style: .default, title: "Изменить") { (action, indexPath) in
			let editProjectViewController = EditProjectViewController()
			let test = self.projectList[indexPath.row]
			editProjectViewController.delegate = self
			editProjectViewController.projects = test.title
			self.present(editProjectViewController, animated: true, completion: nil)
			print("share")
		}
		
		edit.backgroundColor = UIColor.lightGray
		return [delete, edit]
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
			performSegue(withIdentifier: "goToTaskTimer", sender: self)
		default:
			break
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showAllInformationOfRestaurant" {
			if let indexPath = tableView.indexPathForSelectedRow {
				let destionationController = segue.destination as! ProjectTimeVC
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
