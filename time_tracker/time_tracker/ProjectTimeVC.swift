//
//  ProjectTimeVC.swift
//  time_tracker
//
//  Created by Pavel on 11/11/2018.
//  Copyright © 2018 Pavel. All rights reserved.
//

import UIKit
import CoreData

protocol ProjectTimeVCDelegate {
	func reloadTime(time: TasksList)
}

class ProjectTimeVC: UIViewController {
	
	@IBOutlet weak var taskName: UILabel!
	@IBOutlet weak var timeCount: UILabel!
	@IBOutlet weak var startButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!
	@IBOutlet weak var pauseButton: UIButton!
	
	var task: TasksList?
	var timer = Timer()
	var hrs = 0
	var min = 0
	var sec = 0
	var diffHrs = 0
	var diffMins = 0
	var diffSecs = 0
	var time = 0
	var timeFinal = ""
	var buttonCount = 0
	var delegate:	ProjectTimeVCDelegate!
	var resumeTapped = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		taskName.text = task?.name
		timeCount.text = countString(time: hrs) + ":" + countString(time: min) + ":" + countString(time: sec)
		NotificationCenter.default.addObserver(self, selector: #selector(pauseWhenBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
	}
	
	func runTimer() {
		startButton.isHidden = true
		pauseButton.isHidden = false
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
	}
	
	@IBAction func startPauseButtonTaped(_ sender: Any) {
//		UserDefaults.standard.set(true, forKey: "stateTimer")
		buttonCount = 1
		runTimer()
	}
	
	@objc func pauseWhenBackground() {
		self.timer.invalidate()
		let shared = UserDefaults.standard
		shared.set(Date(), forKey: "savedTime")
	}
	
	@objc func startTimer() {
		sec += 1
		updateUI()
	}
	
	private func updateUI() {
		if sec == 60 {
			sec = 0
			min += 1
		} else if min == 60 {
			sec = 0
			min = 0
			hrs += 1
		}
		editTimeCount()
		timeCount.text = countString(time: hrs) + ":" + countString(time: min) + ":" + countString(time: sec)
		timeFinal = countString(time: hrs) + ":" + countString(time: min) + ":" + countString(time: sec)
	}
	
	@objc func willEnterForeground() {
		if buttonCount == 1 {
			if let savedDate = UserDefaults.standard.object(forKey: "savedTime") as? Date {
				let time = getTimeDifference(startDate: savedDate)
				refresh(hours: time.0, mins: time.1, secs: time.2)
			}
		}
	}
	
	func getTimeDifference(startDate: Date) -> (Int, Int, Int) {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
		diffHrs = components.hour!
		diffMins = components.minute!
		diffSecs = components.second!
		return(diffHrs, diffMins, diffSecs)
	}
	
	func refresh (hours: Int, mins: Int, secs: Int) {
		hrs += hours
		min += mins
		sec += secs
		timeCount.text = countString(time: hrs) + ":" + countString(time: min) + ":" + countString(time: sec)
		runTimer()
	}
	
	@IBAction func cancelScreen(_ sender: Any) {
		dismiss(animated: true) {
			self.helpSaveTime()
		}
	}
	
	@IBAction func pauseButtonTaped(_ sender: Any) {
//		UserDefaults.standard.removeObject(forKey: "stateTimer")
//		UserDefaults.standard.set(false, forKey: "stateTimer")
		if self.resumeTapped == false {
			timer.invalidate()
			editTimeCount()
			timeCount.text = countString(time: hrs) + ":" + countString(time: min) + ":" + countString(time: sec)
			startButton.isHidden = false
			pauseButton.isHidden = true
			buttonCount = 2
		}
	}
	
	func editTimeCount() {
		switch sec {
		case 60...120:
			sec = sec % 60
			min = min + 1
		case 120...180:
			sec = sec % 60
			min = min + 2
		case 180...240:
			sec = sec % 60
			min = min + 3
		case 240...300:
			sec = sec % 60
			min = min + 4
		default:
			break
		}
		switch min {
		case 60...120:
			min = min % 60
			hrs = hrs + 1
		case 120...180:
			min = min % 60
			hrs = hrs + 2
		case 180...240:
			min = min % 60
			hrs = hrs + 3
		case 240...300:
			min = min % 60
			hrs = hrs + 4
		default:
			break
		}
	}
	
	func removeSavedDate() {
		if (UserDefaults.standard.object(forKey: "savedTime") as? Date) != nil {
			UserDefaults.standard.removeObject(forKey: "savedTime")
		}
	}
	
	@IBAction func stopButtonTaped(_ sender: Any) {
		dismiss(animated: true) {
			self.helpSaveTime()
		}
		print("stoped")
	}
	
	func helpSaveTime() {
		timer.invalidate()
		time = 0
		saveTime(hours: hrs, minutes: min, seconds: sec)
		delegate.reloadTime(time: self.task!)
	}
	
	func saveTime(hours: Int, minutes: Int, seconds: Int) {
		let context = CoreDataManager.shared.persistentContainer.viewContext
//		task?.time = time
		task?.hours = Int64(hours)
		task?.minutes = Int64(minutes)
		task?.seconds = Int64(seconds)
		do {
			try context.save()
		} catch {
		}
	}
	
	func countString(time: Int) -> String {
		return time > 9 ? "\(time)" : "0\(time)"
	}
	
}
