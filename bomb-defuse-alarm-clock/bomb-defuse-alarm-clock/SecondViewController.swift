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
    
    @IBAction func CreateAlarm(_ sender: Any) {
        
        let adjustedTime = convertTime(setTimeInput: alarmTime.date.description)

        let label = UILabel()
        label.frame = CGRect(x: 50.0, y: 400.0, width: 300.0, height: 30.0)
        label.text = adjustedTime
        self.view.addSubview(label)
    }
    
    
    
}

