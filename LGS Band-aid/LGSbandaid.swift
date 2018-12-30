//
//  LGSbandaid.swift
//  LGS Band-aid
//
//  Created by Jeff on 12/29/18.
//  Copyright © 2018 J∆•Softcode. All rights reserved.
//

import Foundation
import AppKit

class LGSbandaid {
	
	var timeLGSlaunched = Date().addingTimeInterval(32768)
	var timeUpdaterKilled = Date().addingTimeInterval(32768)
	var LGSappName = "Logitech Gaming Software"
	var LGSrunningTime = -1
	let timeHistory = TimeHistory()
	
	
	func setup(theUI:AppDelegate) {
		theUI.setLGSrunStatus(status: "pending")
		theUI.setLGSlaunchTime(minutes: -1)
		theUI.setLGSbestTime(status: "")
		theUI.setUpdaterRunStatus(status: "pending")
		theUI.setUpdaterKillTime(minutes: -1)
	}
	
	@objc func timerTrigger(timer:Timer) {		//@objc required by Timer
		let theUI = timer.userInfo as! AppDelegate
		var LGSisRunning = false
		var UpdaterIsRunning = false
		var updaterApp:NSRunningApplication = NSWorkspace.shared.frontmostApplication!	//placeholder
		
		let runningApplications: [NSRunningApplication] = NSWorkspace.shared.runningApplications
		
		for app in runningApplications {
			if app.bundleIdentifier == "com.Logitech.Updater" {
				UpdaterIsRunning = true
				updaterApp = app
			}
			if app.bundleIdentifier == "com.logitech.gaming" {
				LGSisRunning = true
				LGSappName = app.localizedName!
			}
		}
		
		if LGSisRunning {
			theUI.setLGSrunStatus(status: "Running")
		} else {
			if LGSrunningTime >= 0 { timeHistory.addTime(time: LGSrunningTime) }
			launchLGS()
			theUI.setLGSrunStatus(status: "Relaunched")
			timeLGSlaunched = Date()
			theUI.setLGSbestTime(status: "Recents: \(timeHistory.returnTimesCommaSeparated())")
		}
		LGSrunningTime = Int(Date().timeIntervalSince(timeLGSlaunched))/60
		theUI.setLGSlaunchTime(minutes: LGSrunningTime)
		
		if UpdaterIsRunning {
			let task = Process()
			task.launchPath = "/usr/bin/osascript"
			task.arguments = ["-e tell application \"\(updaterApp.localizedName ?? "Logitech Updater")\" to quit"]
			task.launch()
			theUI.setUpdaterRunStatus(status: "Killed!")
			timeUpdaterKilled = Date()
		} else {
			theUI.setUpdaterRunStatus(status: "Not running")
		}
		theUI.setUpdaterKillTime(minutes: Int(Date().timeIntervalSince(timeUpdaterKilled))/60)
	}
	
	func launchLGS() {
		let task = Process()
		task.launchPath = "/usr/bin/osascript"
		task.arguments = ["-e tell application \"\(LGSappName)\" to open"]
		task.launch()
	}
}
