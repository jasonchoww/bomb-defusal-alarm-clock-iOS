//
//  SecondViewController.swift
//  bomb-defuse-alarm-clock
//
//  Created by Jason Chow on 12/5/18.
//  Copyright © 2018 Jason Chow Justin Shee. All rights reserved.
//

import UIKit
import UserNotifications


class SecondViewController: UIViewController {
    
    //Date picker object on storyboard
    @IBOutlet weak var alarmTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // request for allowing notifcations (alarm request)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        
        //uncomment resetState() to reset all saved data, recomment to run app in normal state
        //resetState()
        loadStartState()
        
        if startApp == false{
            saveState()
        }
        
        loadState()
        
        //one alarm, sets alarm 2 settings to false
        oneAlarm()
        
        //Removes initial labels if they do not exist at start up
        if alarm1Active == false{
            //removeLabel1.removeFromSuperview()
            removeLabel1.isHidden = true
        }
        if alarm2Active == false{
            //removeLabel2.removeFromSuperview()
            removeLabel2.isHidden = true
        }
        
        if alarm1Showing == false{
            alarmLabel1.isHidden = true
        }
        
        if alarm2Showing == false{
            alarmLabel2.isHidden = true
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
    @IBOutlet weak var alarmLabel1: UILabel!
    @IBOutlet weak var alarmLabel2: UILabel!
    
    var alarmLabel1String = ""
    var alarmLabel2String = ""
    var adjustedTime1 = ""
    var adjustedTime2 = ""
    
    //Uneditted Alarm Time for setting alert
    var alertTime1 = ""
    
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
            adjustedTime1 = convertTimeLabel(setTimeInput: alarmTime.date.description)
            
            alertTime1 = alarmTime.date.description
            convertTimeAlarm(setTimeInput: alarmTime.date.description)
            
            //creates label with alarm
            alarmLabel1.text = adjustedTime1
            alarmLabel1String = adjustedTime1
            
            //self.view.addSubview(alarmLabel1)
            removeLabel1.isHidden = false
            alarmLabel1.isHidden = false
            
            //sets booleans to true to reflect active alarm settings
            alarm1Active = true
            alarm1ActiveRing = true
            alarm1Showing = true
            switch1.isOn = true
            
        } else if alarm2Active == false{
            
            /*COMMENTED OUT FOR A SINGLE ALARM
            
            //calls function to parse time format for alarm time
            //adjustedTime is in the format hh:mm a
            adjustedTime2 = convertTimeLabel(setTimeInput: alarmTime.date.description)
            
            convertTimeAlarm(setTimeInput: alarmTime.date.description)
            
            //creates label with alarm
            alarmLabel2.text = adjustedTime2
            alarmLabel2String = adjustedTime2
            
            //self.view.addSubview(alarmLabel2)
            removeLabel2.isHidden = false
            alarmLabel2.isHidden = false
            
            //sets booleans to true to reflect active alarm settings
            alarm2Active = true
            alarm2ActiveRing = true
            alarm2Showing = true
            switch2.isOn = true
            
            */
            createAlert(title: "Maximum amount of alarms reached", message: "Please remove an alarm to add a new alarm")
            print("Maximum amount of alarms already set")
            
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
                alarmLabel1.isHidden = true
                alarm1ActiveRing = false
                alarm1Showing = false
                
                clearNotifcations()
                print("alarm 1 is deactive but still exists")
            }else{
                alarmLabel1.text = alarmLabel1String
                alarmLabel1.isHidden = false
                alarm1ActiveRing = true
                alarm1Showing = true
                
                convertTimeAlarm(setTimeInput: alertTime1)
                print("alarm 1 is active")
            }
        }else{
            alarm1Active = false
            alarm1ActiveRing = false
            switch1.isOn = false
            
            clearNotifcations()
            print("alarm 1 has not been created")
        }
        saveState()
    }
    
    //function for the switch controlling alarm2
    @IBAction func alarmSwitch2(_ sender: Any) {
        if alarm2Active == true{
            if alarm2Showing == true{
                alarmLabel2.isHidden = true
                alarm2ActiveRing = false
                alarm2Showing = false
                print("alarm 2 is deactive but still exists")
            }else{
                alarmLabel2.text = alarmLabel2String
                alarmLabel2.isHidden = false
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
    
    @IBAction func removeAlarm1(_ sender: Any) {
        alarm1ActiveRing = false
        alarm1Active = false
        alarm1Showing = false
        
        alarmLabel1String = ""
        alarmLabel1.text = alarmLabel1String
        removeLabel1.isHidden = true
        switch1.isOn = false
        
        clearNotifcations()
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
        
        alert.addAction(UIAlertAction(title:"Accept", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //EVERYTHING BELOW IS STATES FOR SAVED DATA
    
    //start states
    func appStartState(){
        let defaults = UserDefaults.standard
        defaults.set(startApp, forKey: "startApp")
    }
    
    func loadStartState(){
        let defaults = UserDefaults.standard
        startApp = defaults.bool(forKey: "startApp")
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
        
        defaults.set(alertTime1, forKey: "alertTime1")
    }
    
    //loads the state of app
    func loadState(){
        let defaults = UserDefaults.standard
        
        alarm1ActiveRing = defaults.bool(forKey: "alarm1ActiveRing")
        alarm2ActiveRing = defaults.bool(forKey: "alarm2ActiveRing")
        
        alarm1Active = defaults.bool(forKey: "alarm1Active")
        alarm2Active = defaults.bool(forKey: "alarm2Active")
        
        alarm1Showing = defaults.bool(forKey: "alarm1Showing")
        alarm2Showing = defaults.bool(forKey: "alarm2Showing")
        
        alarmLabel1String = defaults.string(forKey: "alarmLabel1String")!
        alarmLabel2String = defaults.string(forKey: "alarmLabel2String")!
        
        alertTime1 = defaults.string(forKey: "alertTime1")!
        
        if alarm1ActiveRing == true{
            alarmLabel1.text = alarmLabel1String
            alarmLabel1.isHidden = false
            alarm1Showing = true
            switch1.isOn = true
        }
        
        if alarm2ActiveRing == true{
            alarmLabel2.text = alarmLabel2String
            alarmLabel2.isHidden = false
            alarm2Showing = true
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
        
        //alarm 1 settings
        alarm1ActiveRing = false
        alarm1Active = false
        alarm1Showing = false
        alarmLabel1String = ""
        adjustedTime1 = ""
        alertTime1 = ""
        
        //alarm 2 settings
        alarm2ActiveRing = false
        alarm2Active = false
        alarm2Showing = false
        alarmLabel2String = ""
        adjustedTime2 = ""
        
        startApp = false
        
        oneAlarm()
        clearNotifcations()
        saveState()
        loadState()
        
        print("All states have been reset")
    }
    
    //use this function in all codes that modify second alarm to shut down alarm 2 completely, shutting down alarm 2 completely due to notification being allowed to have one set at a time
    func oneAlarm(){
        alarm2Active = false
        alarm2Showing = false
        alarmLabel2.isHidden = true
        removeLabel2.isHidden = true
        switch2.isHidden = true
    }
    
    
    
}





