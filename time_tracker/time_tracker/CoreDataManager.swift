//
//  CoreDataManager.swift
//  time_tracker
//
//  Created by Pavel on 20/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import CoreData

struct CoreDataManager {
	static let shared = CoreDataManager()
	// will live forever as long as your application is still alive, it's properties will too
	let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "time_trackerDataModel")
		container.loadPersistentStores { (storeDescription, err) in
			if let err = err {
				fatalError("Loading of store failed: \(err)")
			}
		}
		return container
	}()
	
	func createNewProject(projectName: String, red: Double, green: Double, blue: Double) -> (ProjectsList?, Error?) {
		let context = persistentContainer.viewContext
		let projectList = NSEntityDescription.insertNewObject(forEntityName: "ProjectsList", into: context) as! ProjectsList
		projectList.name = projectName
		projectList.red = red
		projectList.green = green
		projectList.blue = blue
		projectList.tasksCount = "\(0)"
		do {
			try context.save()
			return (projectList, nil)
		} catch {
			print(error.localizedDescription)
			return (nil, error)
		}
	}
	
	func createNewTask(name: String, project: ProjectsList) {
		let context = persistentContainer.viewContext
		let newTask = NSEntityDescription.insertNewObject(forEntityName: "TasksList", into: context) as! TasksList
		newTask.name = name
		newTask.projectsList = project
		newTask.time = "00:00:00"
		do {
			try context.save()
		} catch {
		}
	}
	
}
