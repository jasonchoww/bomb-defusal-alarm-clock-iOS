//
//  SecondViewController.swift
//  bomb-defuse-alarm-clock
//
//  Created by Jason Chow on 12/5/18.
//  Copyright © 2018 Jason Chow Justin Shee. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    //Date picker object on storyboard
    @IBOutlet weak var alarmTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Removes initial labels if they do not exist at start up
        if alarm1Active == false{
            //removeLabel1.removeFromSuperview()
            removeLabel1.isHidden = true
        }
        if alarm2Active == false{
            //removeLabel2.removeFromSuperview()
            removeLabel2.isHidden = true
        }
        
        //uncomment resetState() to reset all saved data, recomment to run app in normal state
        //resetState()
        loadState()
        if startApp == false{
            saveState()
        }
        
    }
    
    //if the app is the first time running it will not load any states which causes nil error
    var startApp = false
    
    //active alarm that will ring (alarms that are on currently)
    var alarm1ActiveRing = false
    var alarm2ActiveRing = false
    
    //alarms currently saved (even when alarm is off, saved in the data)
    var alarm1Active = false
    var alarm2Active = false
    
    //Shows the alarm label (alarm text that shows up)
    var alarm1Showing = false
    var alarm2Showing = false
    
    //Alarm labels, adjustedTime: formatted time after receiving from UI
    var alarmLabel1 = UILabel()
    var alarmLabel2 = UILabel()
    var alarmLabel1String = ""
    var alarmLabel2String = ""
    var adjustedTime1 = ""
    var adjustedTime2 = ""
    
    //Button to remove alarm labels
    @IBOutlet weak var removeLabel1: UIButton!
    @IBOutlet weak var removeLabel2: UIButton!
    
    //Switch for on/off (for the ringer/label)
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    
    //Creates label that displays alarm with (off/on switch) and creates locale alarm
    //Two alarms total, if exceeds it shall not create additonal alarms and send an alert
    @IBAction func CreateAlarm(_ sender: Any) {
        startApp = true
        appStartState()
        
        if alarm1Active == false {
            //calls function to parse time format for alarm time
            //adjustedTime is in the format hh:mm a
            adjustedTime1 = convertTime(setTimeInput: alarmTime.date.description)
            
            //creates label with alarm
            createAlarmLabel1()
            alarmLabel1.text = adjustedTime1
            alarmLabel1String = adjustedTime1
            
            self.view.addSubview(alarmLabel1)
            removeLabel1.isHidden = false
            
            //sets booleans to true to reflect active alarm settings
            alarm1Active = true
            alarm1ActiveRing = true
            alarm1Showing = true
            switch1.isOn = true
            
        } else if alarm2Active == false{
            //calls function to parse time format for alarm time
            //adjustedTime is in the format hh:mm a
            adjustedTime2 = convertTime(setTimeInput: alarmTime.date.description)
            
            //creates label with alarm
            createAlarmLabel2()
            alarmLabel2.text = adjustedTime2
            alarmLabel2String = adjustedTime2
            
            self.view.addSubview(alarmLabel2)
            removeLabel2.isHidden = false
            
            //sets booleans to true to reflect active alarm settings
            alarm2Active = true
            alarm2ActiveRing = true
            alarm2Showing = true
            switch2.isOn = true
            
        }else{
            //creates alert for maximum amount of alarms (2)
            createAlert(title: "Maximum amount of alarms reached", message: "Please remove an alarm to add a new alarm")
            print("Maximum amount of alarms already set")
        }
        
        saveState()
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
                createAlarmLabel1()
                alarmLabel1.text = alarmLabel1String
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
        saveState()
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
                createAlarmLabel2()
                alarmLabel2.text = alarmLabel2String
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
        saveState()
    }
    
    //creates alarm labels when the alarm is created
    func createAlarmLabel1(){
        alarmLabel1.frame = CGRect(x: 125.0, y: 400.0, width: 300.0, height: 30.0)
        
    }
    func createAlarmLabel2(){
        alarmLabel2.frame = CGRect(x: 125.0, y: 475.0, width: 300.0, height: 30.0)
    }
    
    
    @IBAction func removeAlarm1(_ sender: Any) {
        alarm1ActiveRing = false
        alarm1Active = false
        alarm1Showing = false
        
        alarmLabel1String = ""
        alarmLabel1.text = alarmLabel1String
        removeLabel1.isHidden = true
        switch1.isOn = false
        
        saveState()
        loadState()
        
        print("removed alarm1")
    }
    
    @IBAction func removeAlarm2(_ sender: Any) {
        alarm2ActiveRing = false
        alarm2Active = false
        alarm2Showing = false
        
        alarmLabel2String = ""
        alarmLabel2.text = alarmLabel2String
        removeLabel2.isHidden = true
        switch2.isOn = false
        
        saveState()
        loadState()
        
        print("removed alarm2")
    }
    
    //alert function
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title:"Okay", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //EVERYTHING BELOW IS STATES FOR SAVED DATA
    
    //start states
    func appStartState(){
        let defaults = UserDefaults.standard
        defaults.set(startApp, forKey: "startApp")
    }
    
    //saves the state of app
    func saveState(){
        let defaults = UserDefaults.standard
        defaults.set(alarm1ActiveRing, forKey: "alarm1ActiveRing")
        defaults.set(alarm2ActiveRing, forKey: "alarm2ActiveRing")
        defaults.set(alarm1Active, forKey: "alarm1Active")
        defaults.set(alarm2Active, forKey: "alarm2Active")
        defaults.set(alarm1Showing, forKey: "alarm1Showing")
        defaults.set(alarm2Showing, forKey: "alarm2Showing")
        defaults.set(alarmLabel1String, forKey: "alarmLabel1String")
        defaults.set(alarmLabel2String, forKey: "alarmLabel2String")
        
    }
    
    //loads the state of app
    func loadState(){
        let defaults = UserDefaults.standard
        
        startApp = defaults.bool(forKey: "startApp")
        
        alarm1ActiveRing = defaults.bool(forKey: "alarm1ActiveRing")
        alarm2ActiveRing = defaults.bool(forKey: "alarm2ActiveRing")
        
        alarm1Active = defaults.bool(forKey: "alarm1Active")
        alarm2Active = defaults.bool(forKey: "alarm2Active")
        
        alarm1Showing = defaults.bool(forKey: "alarm1Showing")
        alarm2Showing = defaults.bool(forKey: "alarm2Showing")
        
        alarmLabel1String = defaults.string(forKey: "alarmLabel1String")!
        alarmLabel2String = defaults.string(forKey: "alarmLabel2String")!
        
        if alarm1ActiveRing == true{
            createAlarmLabel1()
            alarmLabel1.text = alarmLabel1String
            self.view.addSubview(alarmLabel1)
            switch1.isOn = true
        }
        if alarm2ActiveRing == true{
            createAlarmLabel2()
            alarmLabel2.text = alarmLabel2String
            self.view.addSubview(alarmLabel2)
            switch2.isOn = true
        }
        
        if alarm1Active == true{
            removeLabel1.isHidden = false
        }
        if alarm2Active == true{
            removeLabel2.isHidden = false
        }
        
        
    }
    
    //resets all values and storyboard
    func resetState(){
        alarm1ActiveRing = false
        alarm2ActiveRing = false
        alarm1Active = false
        alarm2Active = false
        alarm1Showing = false
        alarm2Showing = false
        startApp = false
        
        alarmLabel1String = ""
        alarmLabel2String = ""
        adjustedTime1 = ""
        adjustedTime2 = ""
        
        saveState()
        loadState()
    }
    
    
    
}





