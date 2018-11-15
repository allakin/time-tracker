//
//  CreateNewTaskVC.swift
//  time_tracker
//
//  Created by Pavel on 13/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class CreateNewTaskVC: UIViewController {
	
	@IBOutlet weak var newTaskTextField: UITextField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	@IBAction func newTaskButton(_ sender: Any) {
		performSegue(withIdentifier: "goToTimer", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToTimer" {
			let destionationController = segue.destination as! ProjectTimeVC
			guard let newTask = newTaskTextField.text else {return}
			let task = NewTask(taskName: newTask)
			destionationController.task = task
		}
	}
	
}
