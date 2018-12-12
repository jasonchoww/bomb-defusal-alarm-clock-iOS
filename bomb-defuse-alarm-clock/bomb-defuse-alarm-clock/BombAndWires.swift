//
//  BombAndWires.swift
//  bomb-defuse-alarm-clock
//
//  Created by SCMACEXT-10 on 12/10/18.
//  Copyright © 2018 Jason Chow Justin Shee. All rights reserved.
//

import Foundation

struct BombAndWires:Equatable {
    var wireColorView: [String] = ["red", "blue", "green"]
    var wireColorTapOrder: [String] = ["red", "blue", "green"]
    let defaults = UserDefaults.standard
    
    mutating func loadDefaults() {
        if(defaults.array(forKey: "TapPattern") == nil) {
            self.defaults.set(self.wireColorView, forKey: "TapPattern")
        } else {
            self.wireColorView = defaults.array(forKey: "TapPattern") as! [String]
        }
    }
    
    mutating func setupTapOrder() {
        self.wireColorTapOrder = [self.wireColorView[0],self.wireColorView[1], self.wireColorView[2]]
    }
    
    func getWireColorTapOrder(index: Int) -> String {
        return self.wireColorTapOrder[index]
    }
    
    mutating func randomize() {
        let randomInt0 = Int(arc4random() % 3)
        var randomInt1 = -1
        self.wireColorTapOrder[0] = self.wireColorView[randomInt0]
        switch (randomInt0) {
        case 0:
            randomInt1 = Int((arc4random() % 2) + 1)
            self.wireColorTapOrder[1] = self.wireColorView[randomInt1]
            if(randomInt1 == 1) {
                self.wireColorTapOrder[2] = self.wireColorView[2]
            } else {
                self.wireColorTapOrder[2] = self.wireColorView[1]
            }
        case 1:
            randomInt1 = 2
            self.wireColorTapOrder[1] = self.wireColorView[randomInt1]
            self.wireColorTapOrder[2] = self.wireColorView[0]
        case 2:
            randomInt1 = Int((arc4random() % 2))
            self.wireColorTapOrder[1] = self.wireColorView[randomInt1]
            if(randomInt1 == 0) {
                self.wireColorTapOrder[2] = self.wireColorView[1]
            } else {
                self.wireColorTapOrder[2] = self.wireColorView[0]
            }
        default:
            randomInt1 = -1
        }
    }
    
    func checkIfCorrectTapped(color: String, index: Int) -> Bool {
        return self.wireColorTapOrder[index] == color
    }
    
    func checkIfWrongTapped(color: String, index: Int) -> Bool {
        return self.wireColorTapOrder[index] != color
    }
}
