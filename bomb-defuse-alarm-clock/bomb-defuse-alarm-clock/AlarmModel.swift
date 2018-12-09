//
//  AlarmModel.swift
//  bomb-defuse-alarm-clock
//
//  Created by Jason Chow on 12/5/18.
//  Copyright © 2018 Jason Chow Justin Shee. All rights reserved.
//

import Foundation


//Converts time from UIDatePicker to hh:mm format
func convertTime(setTimeInput: String) -> String{
    
    let setTimeString = setTimeInput
    
    let formatter = DateFormatter()
    let formatterPrint = DateFormatter()
    
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    formatterPrint.dateFormat = "hh:mm a"
    
    let date = formatter.date(from: setTimeString)
    let adjustedTime = formatterPrint.string(from: (date!))
    print("alarm created, time: " + adjustedTime)
    return adjustedTime
    
}








