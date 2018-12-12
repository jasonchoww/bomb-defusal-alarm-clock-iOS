//
//  FirstViewController.swift
//  bomb-defuse-alarm-clock
//
//  Created by Jason Chow on 12/5/18.
//  Copyright © 2018 Jason Chow Justin Shee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var bombAndWires = BombAndWires()
    var timer = Timer()
    var patternStep = 0;
    var seconds = 6
    var bombDefused = false;
    var wrongWireCut = false;
    
    @IBOutlet weak var Color1: UILabel!
    
    @IBOutlet weak var Color2: UILabel!
    
    @IBOutlet weak var Color3: UILabel!
    
    @IBOutlet weak var wire1: UIImageView!
    
    @IBOutlet weak var wire2: UIImageView!
    
    @IBOutlet weak var wire3: UIImageView!
    
    @IBOutlet weak var bomb: UIImageView!
    
    @IBOutlet weak var GameWin: UILabel!

    @IBOutlet weak var TryAgain: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patternStep = 0;
        seconds = 6;
        bombDefused = false;
        GameWin.isHidden = true
        if(!wrongWireCut) {
            TryAgain.isHidden = true
        } else {
            TryAgain.isHidden = false
        }
        Color1.text = bombAndWires.getWireColorTapOrder(index: 0)
        Color2.text = bombAndWires.getWireColorTapOrder(index: 1)
        Color3.text = bombAndWires.getWireColorTapOrder(index: 2)
        wire1.image = UIImage(named: "bluewire.png")!
        wire2.image = UIImage(named: "redwire.png")!
        wire3.image = UIImage(named: "greenwire.png")!
        bomb.image = UIImage(named: "DynamiteWhiteTimer.png")!
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer1:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer2:)))
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer3:)))
        wire1.isUserInteractionEnabled = true
        wire2.isUserInteractionEnabled = true
        wire3.isUserInteractionEnabled = true
        wire1.addGestureRecognizer(tapGestureRecognizer1)
        wire2.addGestureRecognizer(tapGestureRecognizer2)
        wire3.addGestureRecognizer(tapGestureRecognizer3)
        // Do any additional setup after loading the view, typically from a nib.
        //countdownTime.text = countdownTimeString
        
    }
    
    func resetAndRandomize() {
        bombAndWires.randomize()
        Color1.text = bombAndWires.getWireColorTapOrder(index: 0)
        Color2.text = bombAndWires.getWireColorTapOrder(index: 1)
        Color3.text = bombAndWires.getWireColorTapOrder(index: 2)
        viewDidLoad()
    }
    
    var countdownTimeString = String()
    @IBOutlet weak var countdownTime: UILabel!
    
    @objc func counter(){
        
        seconds -= 1
        countdownTime.text = String(seconds)
        
        if seconds == 0 && !bombDefused{
            self.resetAndRandomize()
        } else if bombDefused {
            timer.invalidate()
        }
    }

    @IBAction func startCountdown(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FirstViewController.counter)), userInfo: nil, repeats: true)
    }

    
    @objc func imageTapped(tapGestureRecognizer1: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer1.view as! UIImageView
        tappedImage.image = nil
        if(bombAndWires.checkIfCorrectTapped(color: "blue", index: patternStep)) {
            wrongWireCut = false
            TryAgain.isHidden = true
            patternStep = patternStep + 1
            if(patternStep == 3) {
                GameWin.isHidden = false
                bombDefused = true
            }
        } else if(bombAndWires.checkIfWrongTapped(color: "blue", index: patternStep)) {
            wrongWireCut = true
            TryAgain.isHidden = false
            self.resetAndRandomize()
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer2: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer2.view as! UIImageView
        tappedImage.image = nil
        if(bombAndWires.checkIfCorrectTapped(color: "red", index: patternStep)) {
            wrongWireCut = false
            TryAgain.isHidden = true
            patternStep = patternStep + 1
            if(patternStep == 3) {
                GameWin.isHidden = false;
                bombDefused = true;
            }
        } else if(bombAndWires.checkIfWrongTapped(color: "red", index: patternStep)) {
            wrongWireCut = true
            TryAgain.isHidden = false
            self.resetAndRandomize()
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer3: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer3.view as! UIImageView
        tappedImage.image = nil
        if(bombAndWires.checkIfCorrectTapped(color: "green", index: patternStep)) {
            wrongWireCut = false
            TryAgain.isHidden = true
            patternStep = patternStep + 1
            if(patternStep == 3) {
                GameWin.isHidden = false;
                bombDefused = true;
            }
        } else if(bombAndWires.checkIfWrongTapped(color: "green", index: patternStep)) {
            wrongWireCut = true
            TryAgain.isHidden = false
            self.resetAndRandomize()
        }
    }
}

