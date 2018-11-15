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

class CreateProjectViewController: UIViewController, UITextFieldDelegate {
	
	var delegate: CreateProjectViewControllerDelegate?
	var redColor: CGFloat = 0.94
	var greenColor: CGFloat = 0.12
	var blueColor: CGFloat = 0.35
	
	let titleLabel: UILabel = {
		let text = UILabel()
		text.text = ""
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
		textField.font = UIFont.boldSystemFont(ofSize: 22)
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let addNewProject: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.94, green:0.12, blue:0.35, alpha:1.00)
		button.setTitle("Создать новый проект", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		button.layer.cornerRadius = 25
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
		return button
	}()
	
	let cancelButton: UIButton = {
		let button = UIButton()
//		button.backgroundColor = UIColor(red:0.94, green:0.12, blue:0.35, alpha:1.00)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		button.layer.cornerRadius = 25
		button.setImage(UIImage(named: "close"), for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(cancelClicked), for: .touchUpInside)
		return button
	}()
	
	let colorLabel: UILabel = {
		let text = UILabel()
		text.text = "Выбирете цвет проекта"
		text.textAlignment = .left
		text.textColor = .black
//		text.font = UIFont.boldSystemFont(ofSize: 16)
		text.font = text.font.withSize(14)
		text.translatesAutoresizingMaskIntoConstraints = false
		return text
	}()
	
	let color1: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.85, green:0.07, blue:0.48, alpha:1.00)
		button.layer.cornerRadius = 3
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(color1Clicked), for: .touchUpInside)
		return button
	}()
	
	let color2: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.44, green:0.08, blue:0.90, alpha:1.00)
		button.layer.cornerRadius = 3
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(color2Clicked), for: .touchUpInside)
		return button
	}()
	
	let color3: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.17, green:0.10, blue:0.90, alpha:1.00)
		button.layer.cornerRadius = 3
		button.translatesAutoresizingMaskIntoConstraints = false
button.addTarget(self, action: #selector(color3Clicked), for: .touchUpInside)
		return button
	}()
	
	let color4: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.16, green:0.42, blue:0.90, alpha:1.00)
		button.layer.cornerRadius = 3
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(color4Clicked), for: .touchUpInside)
		return button
	}()
	
	let color5: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.26, green:0.91, blue:0.17, alpha:1.00)
		button.layer.cornerRadius = 3
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(color5Clicked), for: .touchUpInside)
		return button
	}()
	
	let color6: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.89, green:0.87, blue:0.05, alpha:1.00)
		button.layer.cornerRadius = 3
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(color6Clicked), for: .touchUpInside)
		return button
	}()
	
	let color7: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.87, green:0.47, blue:0.12, alpha:1.00)
		button.layer.cornerRadius = 3
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(color7Clicked), for: .touchUpInside)
		return button
	}()
	
	let color8: UIButton = {
		let button = UIButton()
		button.backgroundColor = UIColor(red:0.85, green:0.13, blue:0.14, alpha:1.00)
		button.layer.cornerRadius = 3
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(color8Clicked), for: .touchUpInside)
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		nameProjectTextFiled.delegate = self
		setingUI()
	}
	
	@objc private func color1Clicked() {
		redColor = 0.85
		greenColor = 0.07
		blueColor = 0.48
		color1.layer.borderWidth = 2
		color1.layer.borderColor = UIColor.black.cgColor
		print("change color")
	}
	
	@objc private func color2Clicked() {
		redColor = 0.44
		greenColor = 0.08
		blueColor = 0.90
		color2.layer.borderWidth = 2
		color2.layer.borderColor = UIColor.black.cgColor
		print("change color")
	}
	
	@objc private func color3Clicked() {
		redColor = 0.17
		greenColor = 0.10
		blueColor = 0.90
		color3.layer.borderWidth = 2
		color3.layer.borderColor = UIColor.black.cgColor
		print("change color")
	}
	
	@objc private func color4Clicked() {
		redColor = 0.16
		greenColor = 0.42
		blueColor = 0.90
		color4.layer.borderWidth = 2
		color4.layer.borderColor = UIColor.black.cgColor
		print("change color")
	}
	
	@objc private func color5Clicked() {
		redColor = 0.26
		greenColor = 0.91
		blueColor = 0.17
		color5.layer.borderWidth = 2
		color5.layer.borderColor = UIColor.black.cgColor
		print("change color")
	}
	
	@objc private func color6Clicked() {
		redColor = 0.89
		greenColor = 0.87
		blueColor = 0.05
		color6.layer.borderWidth = 2
		color6.layer.borderColor = UIColor.black.cgColor
		print("change color")
	}
	
	@objc private func color7Clicked() {
		redColor = 0.87
		greenColor = 0.47
		blueColor = 0.12
		color7.layer.borderWidth = 2
		color7.layer.borderColor = UIColor.black.cgColor
		print("change color")
	}
	
	@objc private func color8Clicked() {
		redColor = 0.85
		greenColor = 0.13
		blueColor = 0.14
		color8.layer.borderWidth = 2
		color8.layer.borderColor = UIColor.black.cgColor
		print("change color")
	}
	
	@objc private func buttonClicked() {
		dismiss(animated: true) {
			guard let text = self.nameProjectTextFiled.text else {return}
			let project = Project(title: text, red: self.redColor, green: self.greenColor, blue: self.blueColor, alpha: 1.00)
			self.delegate?.addNewProject(name: project)
		}
	}
	
	@objc private func cancelClicked() {
		dismiss(animated: true, completion: nil)
	}
	
	func setingUI() {
		view.addSubview(cancelButton)
		cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
		cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		cancelButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
		cancelButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
		view.addSubview(titleLabel)
		titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
		titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		view.addSubview(nameProjectTextFiled)
		nameProjectTextFiled.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50).isActive = true
		nameProjectTextFiled.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		nameProjectTextFiled.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		nameProjectTextFiled.heightAnchor.constraint(equalToConstant: 50).isActive = true
		view.addSubview(colorLabel)
		colorLabel.topAnchor.constraint(equalTo: nameProjectTextFiled.bottomAnchor, constant: 50).isActive = true
		colorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		colorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		view.addSubview(color1)
		color1.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20).isActive = true
		color1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		color1.widthAnchor.constraint(equalToConstant: 20).isActive = true
		color1.heightAnchor.constraint(equalToConstant: 20).isActive = true
		view.addSubview(color2)
		color2.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20).isActive = true
		color2.leftAnchor.constraint(equalTo: color1.rightAnchor, constant: 10).isActive = true
		color2.widthAnchor.constraint(equalToConstant: 20).isActive = true
		color2.heightAnchor.constraint(equalToConstant: 20).isActive = true
		view.addSubview(color3)
		color3.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20).isActive = true
		color3.leftAnchor.constraint(equalTo: color2.rightAnchor, constant: 10).isActive = true
		color3.widthAnchor.constraint(equalToConstant: 20).isActive = true
		color3.heightAnchor.constraint(equalToConstant: 20).isActive = true
		view.addSubview(color4)
		color4.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20).isActive = true
		color4.leftAnchor.constraint(equalTo: color3.rightAnchor, constant: 10).isActive = true
		color4.widthAnchor.constraint(equalToConstant: 20).isActive = true
		color4.heightAnchor.constraint(equalToConstant: 20).isActive = true
		view.addSubview(color5)
		color5.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20).isActive = true
		color5.leftAnchor.constraint(equalTo: color4.rightAnchor, constant: 10).isActive = true
		color5.widthAnchor.constraint(equalToConstant: 20).isActive = true
		color5.heightAnchor.constraint(equalToConstant: 20).isActive = true
		view.addSubview(color6)
		color6.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20).isActive = true
		color6.leftAnchor.constraint(equalTo: color5.rightAnchor, constant: 10).isActive = true
		color6.widthAnchor.constraint(equalToConstant: 20).isActive = true
		color6.heightAnchor.constraint(equalToConstant: 20).isActive = true
		view.addSubview(color7)
		color7.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20).isActive = true
		color7.leftAnchor.constraint(equalTo: color6.rightAnchor, constant: 10).isActive = true
		color7.widthAnchor.constraint(equalToConstant: 20).isActive = true
		color7.heightAnchor.constraint(equalToConstant: 20).isActive = true
		view.addSubview(color8)
		color8.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20).isActive = true
		color8.leftAnchor.constraint(equalTo: color7.rightAnchor, constant: 10).isActive = true
		color8.widthAnchor.constraint(equalToConstant: 20).isActive = true
		color8.heightAnchor.constraint(equalToConstant: 20).isActive = true
		view.addSubview(addNewProject)
		addNewProject.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
		addNewProject.widthAnchor.constraint(equalToConstant: 300).isActive = true
		addNewProject.heightAnchor.constraint(equalToConstant: 50).isActive = true
		addNewProject.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	
}
