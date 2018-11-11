//
//  EditProjectViewController.swift
//  time_tracker
//
//  Created by Pavel on 11/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import Foundation
import UIKit

protocol EditProjectViewControllerDelegate {
	func editProject(name: Project)
}

class EditProjectViewController: UIViewController {
	
	var delegate: EditProjectViewControllerDelegate?
	
	var projects: String? {
		didSet{
			editNameProjectTextFiled.text = projects
		}
	}
	
	let titleLabel: UILabel = {
		let text = UILabel()
		text.text = "Изменить проект"
		text.textAlignment = .center
		text.textColor = .black
		text.font = UIFont.boldSystemFont(ofSize: 18)
		//		text.font = text.font.withSize(14)
		text.translatesAutoresizingMaskIntoConstraints = false
		return text
	}()
	
	let editNameProjectTextFiled: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Название проекта"
		textField.textColor = UIColor(red:0.94, green:0.12, blue:0.35, alpha:1.00)
		textField.font = UIFont.boldSystemFont(ofSize: 18)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let addNewProject: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.94, green:0.12, blue:0.35, alpha:1.00)
		button.setTitle("Сохранить", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		button.layer.cornerRadius = 25
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setingUI()
	}
	
	@objc private func buttonClicked() {
		dismiss(animated: true) {
			guard let text = self.editNameProjectTextFiled.text else {return}
			let project = Project(title: text, red: 0.23, green: 0.12, blue: 0.15, alpha: 0.1)
			self.delegate?.editProject(name: project)
		}
	}
	
	func setingUI() {
		view.addSubview(titleLabel)
		titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
		titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		view.addSubview(editNameProjectTextFiled)
		editNameProjectTextFiled.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50).isActive = true
		editNameProjectTextFiled.widthAnchor.constraint(equalToConstant: 300).isActive = true
		editNameProjectTextFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true
		editNameProjectTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		view.addSubview(addNewProject)
		addNewProject.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
		addNewProject.widthAnchor.constraint(equalToConstant: 200).isActive = true
		addNewProject.heightAnchor.constraint(equalToConstant: 50).isActive = true
		addNewProject.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	
}

