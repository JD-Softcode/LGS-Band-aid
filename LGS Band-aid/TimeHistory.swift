//
//  TimeHistory.swift
//  LGS Band-aid
//
//  Created by Jeff on 12/30/18.
//  Copyright © 2018 J∆•Softcode. All rights reserved.
//

import Foundation

class TimeHistory {
	
	var times:[Int] = [0,0,0,0,0]
	
//	init() {	//constructor
//		times = [0,0,0,0,0]
//	}
	
	func addTime(time:Int) {
		var timeInserted = false
		
		for (index,value) in times.enumerated() {
			if value == 0 && !timeInserted {
				times[index] = time
				timeInserted = true
			}
		}
		
		if !timeInserted {		//array is full, so shuffle down
			for (index,value) in times.enumerated() {
				if index > 0 {
					if index == (times.count - 1) {
						times[index] = time
					} else {
						times[index-1] = value
					}
				}
			}
		}
	}
	
	func returnTimesCommaSeparated() -> String {
		var output = ""
		for value in times {
			if value != 0  {
				output += "\(value), "
			}
		}
		if output.hasSuffix(", ") {
			output = String(output.dropLast(2))
		}
		return output
	}
	
}
