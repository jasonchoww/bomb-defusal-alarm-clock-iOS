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
    
    @IBOutlet weak var Color1: UILabel!
    
    @IBOutlet weak var Color2: UILabel!
    
    @IBOutlet weak var Color3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Color1.text = bombAndWires.getWireColorTapOrder(index: 0)
        Color2.text = bombAndWires.getWireColorTapOrder(index: 1)
        Color3.text = bombAndWires.getWireColorTapOrder(index: 2)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func ColorPatternRandomizer(_ sender: UIButton) {
        bombAndWires.randomize()
        Color1.text = bombAndWires.getWireColorTapOrder(index: 0)
        Color2.text = bombAndWires.getWireColorTapOrder(index: 1)
        Color3.text = bombAndWires.getWireColorTapOrder(index: 2)
    }
    
}

