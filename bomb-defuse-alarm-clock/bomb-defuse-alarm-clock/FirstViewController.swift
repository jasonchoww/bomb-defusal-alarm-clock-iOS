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
    
    @IBOutlet weak var wire1: UIImageView!
    
    @IBOutlet weak var wire2: UIImageView!
    
    @IBOutlet weak var wire3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Color1.text = bombAndWires.getWireColorTapOrder(index: 0)
        Color2.text = bombAndWires.getWireColorTapOrder(index: 1)
        Color3.text = bombAndWires.getWireColorTapOrder(index: 2)
        wire1.image = UIImage(named: "bluewire.png")!
        wire2.image = UIImage(named: "redwire.png")!
        wire3.image = UIImage(named: "greenwire.png")!
        
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
    }
    
    @objc func imageTapped(tapGestureRecognizer1: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer1.view as! UIImageView
        tappedImage.image = nil
    }
    
    @objc func imageTapped(tapGestureRecognizer2: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer2.view as! UIImageView
        tappedImage.image = nil
    }
    
    @objc func imageTapped(tapGestureRecognizer3: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer3.view as! UIImageView
        tappedImage.image = nil
    }
    
    @IBAction func ColorPatternRandomizer(_ sender: UIButton) {
        bombAndWires.randomize()
        Color1.text = bombAndWires.getWireColorTapOrder(index: 0)
        Color2.text = bombAndWires.getWireColorTapOrder(index: 1)
        Color3.text = bombAndWires.getWireColorTapOrder(index: 2)
    }
}

