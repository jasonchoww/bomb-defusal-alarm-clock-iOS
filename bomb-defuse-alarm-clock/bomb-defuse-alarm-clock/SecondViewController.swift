//
//  SecondViewController.swift
//  bomb-defuse-alarm-clock
//
//  Created by Jason Chow on 12/5/18.
//  Copyright © 2018 Jason Chow Justin Shee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var alarmTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //active alarm that will ring
    var alarm1ActiveRing = false
    var alarm2ActiveRing = false
    
    //alarms currently saved
    var alarm1Active = false
    var alarm2Active = false
    
    //Shows the alarm label
    var alarm1Showing = false
    var alarm2Showing = false
    
    //Alarm labels
    let alarmLabel1 = UILabel()
    let alarmLabel2 = UILabel()
    
    //Button to remove alarm labels
    @IBOutlet weak var removeLabel1: UIButton!
    @IBOutlet weak var removeLabel2: UIButton!
    
    //Switch for on/off (for the ringer/label)
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    
    //Creates label that displays alarm with (off/on switch) and creates locale alarm
    //Two alarms total, if exceeds it shall not create additonal alarms and send an alert
    @IBAction func CreateAlarm(_ sender: Any) {
        
        if alarm1Active == false {
            //calls function to parse time format for alarm time
            //adjustedTime is in the format hh:mm a
            let adjustedTime = convertTime(setTimeInput: alarmTime.date.description)
            
            //creates label with alarm
            alarmLabel1.frame = CGRect(x: 125.0, y: 400.0, width: 300.0, height: 30.0)
            alarmLabel1.text = adjustedTime
            self.view.addSubview(alarmLabel1)
            
            //sets booleans to true to reflect active alarm settings
            alarm1Active = true
            alarm1ActiveRing = true
            alarm1Showing = true
            switch1.isOn = true
            
        } else if alarm2Active == false{
            //calls function to parse time format for alarm time
            //adjustedTime is in the format hh:mm a
            let adjustedTime = convertTime(setTimeInput: alarmTime.date.description)
            
            //creates label with alarm
            alarmLabel2.frame = CGRect(x: 125.0, y: 475.0, width: 300.0, height: 30.0)
            alarmLabel2.text = adjustedTime
            self.view.addSubview(alarmLabel2)
            
            //sets booleans to true to reflect active alarm settings
            alarm2Active = true
            alarm2ActiveRing = true
            alarm2Showing = true
            switch2.isOn = true

            
        }else{
            print("Maximum amount of alarms already set")
        }
    }
    //function for the switch controlling alarm1
    @IBAction func alarmSwitch1(_ sender: Any) {
        if alarm1Active == true{
            if alarm1Showing == true{
                alarmLabel1.removeFromSuperview()
                alarm1ActiveRing = false
                alarm1Showing = false
                print("alarm 1 is deactive but still exists")
            }else{
                self.view.addSubview(alarmLabel1)
                alarm1ActiveRing = true
                alarm1Showing = true
                print("alarm 1 is active")
            }
        }else{
            alarm1Active = false
            alarm1ActiveRing = false
            switch1.isOn = false
            print("alarm 1 has not been created")
        }
        
    }
    
    //function for the switch controlling alarm2
    @IBAction func alarmSwitch2(_ sender: Any) {
        if alarm2Active == true{
            if alarm2Showing == true{
                alarmLabel2.removeFromSuperview()
                alarm2ActiveRing = false
                alarm2Showing = false
                print("alarm 2 is deactive but still exists")
            }else{
                self.view.addSubview(alarmLabel2)
                alarm2Showing = true
                alarm2ActiveRing = true
                print("alarm 2 is active")
            }
        }else{
            alarm2Active = false
            alarm2ActiveRing = false
            switch2.isOn = false
            print("alarm 2 has not been created")
        }
    }
    

    
}





