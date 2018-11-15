//
//  ProjectTimeVC.swift
//  time_tracker
//
//  Created by Pavel on 11/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit

class ProjectTimeVC: UIViewController {
	
	@IBOutlet weak var taskName: UILabel!
	@IBOutlet weak var timeCount: UILabel!
	@IBOutlet weak var startButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!
	
	var task: NewTask?
	var timer = Timer()
	var time = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		taskName.text = task?.taskName
	}
	
	@IBAction func startPauseButtonTaped(_ sender: Any) {
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
		print("stared")
	}
	
	@objc func startTimer() {
		time += 1
		updateUI()
	}
	
	private func updateUI() {
		var seconds: Int
		var minutes: Int
		var hours: Int
		hours = time/(60*60)
		minutes = (time/60) % 60
		seconds = time % 60
		
		let hoursString = hours > 9 ? "\(hours)" : "0\(hours)"
		let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
		let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
		
		timeCount.text = "\(hoursString):\(minutesString):\(secondsString)"
	}
	
	@IBAction func stopButtonTaped(_ sender: Any) {
		print("stoped")
	}
	
}
