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
	var delegate:	ProjectTimeVCDelegate!
	var resumeTapped = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		taskName.text = task?.name
		NotificationCenter.default.addObserver(self, selector: #selector(pauseWhenBackground(noti:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(noti:)), name: UIApplication.willEnterForegroundNotification, object: nil)
	}
	
	func runTimer() {
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer(t:)), userInfo: nil, repeats: true)
	}
	
	@IBAction func startPauseButtonTaped(_ sender: Any) {
		runTimer()
		startButton.isHidden = true
		pauseButton.isHidden = false
		print("start")
	}
	
	@objc func pauseWhenBackground(noti: Notification) {
		self.timer.invalidate()
		let shared = UserDefaults.standard
		shared.set(Date(), forKey: "savedTime")
	}
	
	@objc func startTimer(t: Timer) {
		sec += 1
//		if sec == 59 {
//			min += 1
//		} else if min == 60 {
//			hrs += 1
//			sec = 0
//			min = 0
//		}
//		timeCount.text = String(format: "%02d : %02d : %02d", self.hrs, self.min, self.sec)
		updateUI()
	}
	
	@objc func willEnterForeground(noti: Notification) {
		if let savedDate = UserDefaults.standard.object(forKey: "savedTime") as? Date {
			(diffHrs, diffMins, diffSecs) = ProjectTimeVC.getTimeDifference(startDate: savedDate)
			
			refresh(hours: diffHrs, mins: diffMins, secs: diffSecs)
		}
	}
	
	static func getTimeDifference(startDate: Date) -> (Int, Int, Int) {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
		return(components.hour!, components.minute!, components.second!)
	}
	
	func refresh (hours: Int, mins: Int, secs: Int) {
		hrs += hours
		min += mins
		sec += secs
		timeCount.text = countString(time: hrs) + ":" + countString(time: min) + ":" + countString(time: sec)
		runTimer()
		
	}
	
	@IBAction func cancelScreen(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func pauseButtonTaped(_ sender: Any) {
		if self.resumeTapped == false {
			timer.invalidate()
			startButton.isHidden = false
			pauseButton.isHidden = true
		}
		print("pause")
	}
	
	func removeSavedDate() {
		if (UserDefaults.standard.object(forKey: "savedTime") as? Date) != nil {
			UserDefaults.standard.removeObject(forKey: "savedTime")
		}
	}
	
	private func updateUI() {
//		var seconds: Int
//		var minutes: Int
//		var hours: Int
//		hrs = time/(60*60)
//		min = (time/60) % 60
//		sec = time % 60
		if sec == 60 {
			min += 1
			sec = 0
		} else if min == 60 {
			sec = 0
			min = 0
			hrs += 1
		}
		
//		let hoursString = hrs > 9 ? "\(hrs)" : "0\(hrs)"
//		let minutesString = min > 9 ? "\(min)" : "0\(min)"
//		let secondsString = sec > 9 ? "\(sec)" : "0\(sec)"
		
		timeCount.text = countString(time: hrs) + ":" + countString(time: min) + ":" + countString(time: sec)
		timeFinal = countString(time: hrs) + ":" + countString(time: min) + ":" + countString(time: sec)
		
	}
	
	@IBAction func stopButtonTaped(_ sender: Any) {
		dismiss(animated: true) {
			self.timer.invalidate()
			self.time = 0
			self.timeFinal != "" ? self.saveTime(time: self.timeFinal) : self.saveTime(time: "00:00:00")
			self.delegate.reloadTime(time: self.task!)
		}
		print("stoped")
	}
	
	func saveTime(time: String) {
		let context = CoreDataManager.shared.persistentContainer.viewContext
		task?.time = time
		do {
			try context.save()
		} catch {
		}
	}
	
	func countString(time: Int) -> String {
		return time > 9 ? "\(time)" : "0\(time)"
	}
	
}
