//
//  AppDelegate.swift
//  LGS Band-aid
//
//  Created by Jeff on 12/29/18.
//  Copyright © 2018 J∆•Softcode. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	@IBOutlet weak var lgsStatusText: NSTextField!
	@IBOutlet weak var lgsLaunchTimeText: NSTextField!
	@IBOutlet weak var lgsBestTimeText: NSTextField!
	@IBOutlet weak var updaterStatusText: NSTextField!
	@IBOutlet weak var updaterKillTimeText: NSTextField!
	
	var myTimer = Timer()
	var theApp = LGSbandaid()

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		//theApp = LGSbandaid()
		
		theApp.setup(theUI: self)
		window.setIsVisible(true)
		
		myTimer = Timer.scheduledTimer(
			timeInterval: 5.0,
			target: theApp,
			selector: #selector(LGSbandaid.timerTrigger),
			userInfo: self,
			repeats: true)
	}

	
	@IBAction func launchLGSbtn(_ sender: NSButton) {
		theApp.launchLGS()
	}
	
	
	@IBAction func quitBtn(_ sender: NSButton) {
		window.close()
	}
	
	func setLGSrunStatus(status: String) {
		lgsStatusText.stringValue = status
	}
	
	func setLGSlaunchTime(minutes: Int) {
		if minutes >= 0 {
			lgsLaunchTimeText.stringValue = "Last launched \(minutes) minute\(correctPlural(number: minutes)) ago."
		} else {
			lgsLaunchTimeText.stringValue = ""
		}
	}
	
	func setLGSbestTime(status: String) {
		lgsBestTimeText.stringValue = status
	}
	
	func setUpdaterRunStatus(status: String) {
		updaterStatusText.stringValue = status
	}
	
	func setUpdaterKillTime(minutes: Int) {
		if minutes >= 0 {
			updaterKillTimeText.stringValue = "Last terminated \(minutes) minute\(correctPlural(number: minutes)) ago."
		} else {
			updaterKillTimeText.stringValue = ""
		}
	}
	
	func correctPlural (number: Int) -> String {
		if number == 1 {return ""}
		else {return "s"}
	}
	
	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}
	

	func applicationWillTerminate(_ aNotification: Notification) {
		myTimer.invalidate()
	}

}

