//
//  CreateProjectViewController.swift
//  time_tracker
//
//  Created by Pavel on 11/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

protocol CreateProjectViewControllerDelegate {
	func addNewProject(name: Project)
}

class CreateProjectViewController: UIViewController {
	
	var delegate: CreateProjectViewControllerDelegate?
	
	let titleLabel: UILabel = {
		let text = UILabel()
		text.text = "Новый проект"
		text.textAlignment = .center
		text.textColor = .black
		text.font = UIFont.boldSystemFont(ofSize: 18)
		//		text.font = text.font.withSize(14)
		text.translatesAutoresizingMaskIntoConstraints = false
		return text
	}()
	
	let nameProjectTextFiled: UITextField = {
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
	
	let colorLabel: UILabel = {
		let text = UILabel()
		text.text = "Задайте цвет проекта"
		text.textAlignment = .center
		text.textColor = .black
		text.font = UIFont.boldSystemFont(ofSize: 16)
		//		text.font = text.font.withSize(14)
		text.translatesAutoresizingMaskIntoConstraints = false
		return text
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setingUI()
	}
	
	@objc private func buttonClicked() {
		dismiss(animated: true) {
			guard let text = self.nameProjectTextFiled.text else {return}
			let project = Project(title: text, red: 0.23, green: 0.12, blue: 0.15, alpha: 0.1)
			self.delegate?.addNewProject(name: project)
		}
	}
	
	func setingUI() {
		view.addSubview(titleLabel)
		titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
		titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		view.addSubview(nameProjectTextFiled)
		nameProjectTextFiled.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50).isActive = true
		nameProjectTextFiled.widthAnchor.constraint(equalToConstant: 300).isActive = true
		nameProjectTextFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true
		nameProjectTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		view.addSubview(colorLabel)
		colorLabel.topAnchor.constraint(equalTo: nameProjectTextFiled.bottomAnchor, constant: 50).isActive = true
		colorLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		colorLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		view.addSubview(addNewProject)
		addNewProject.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
		addNewProject.widthAnchor.constraint(equalToConstant: 200).isActive = true
		addNewProject.heightAnchor.constraint(equalToConstant: 50).isActive = true
		addNewProject.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	
}
