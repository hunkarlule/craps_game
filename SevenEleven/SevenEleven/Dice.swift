//
//  Dice.swift
//  SevenEleven
//
//  Created by hunkar lule on 2018-11-13.
//  Copyright © 2018 hunkar lule. All rights reserved.
//

import Foundation

struct Dice {
    var faceValue = 1
    
   mutating func rollDice() {
     let randomNumber = Int.random(in: 1...6)
        faceValue = randomNumber        
    //return self
    }
}
