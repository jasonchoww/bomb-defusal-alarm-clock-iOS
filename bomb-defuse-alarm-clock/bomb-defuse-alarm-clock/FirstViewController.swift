//
//  FirstViewController.swift
//  bomb-defuse-alarm-clock
//
//  Created by Jason Chow on 12/5/18.
//  Copyright © 2018 Jason Chow Justin Shee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        start.isHidden = true
        countdownTime.text = countdownTimeString
        
    }
    
    var countdownTimeString = String()
    
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var countdownTime: UILabel!

    var seconds = 5
    var timer = Timer()
    
    @objc func counter(){
        
        seconds -= 1
        countdownTime.text = String(seconds)
        
        if seconds == 0{
            timer.invalidate()
        }
    }

    @IBAction func startCountdown(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FirstViewController.counter)), userInfo: nil, repeats: true)
        
    }
    
    

}

