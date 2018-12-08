//
//  Game.swift
//  SevenEleven
//
//  Created by hunkar lule on 2018-11-13.
//  Copyright © 2018 hunkar lule. All rights reserved.
//

import Foundation

struct Game {
    var firstDice = Dice()
    var secondDice = Dice()
    var balance = 0
    var firstBet = 0
    var secondBet = 0
    var totalWL = 0
    var targetPointToWinGame = 0
    var isFirstRoll = true
    var maxBetAllowed = 200
    
    mutating  func roll()  {
        firstDice.rollDice()
        secondDice.rollDice()
    }
    
    mutating func setBets(amount: Int) {
        if isFirstRoll {
            firstBet += amount
        } else {
            secondBet += amount
        }
    }
    
    mutating func checkGameResult() -> Bool {
        if isFirstRoll {
            switch firstDice.faceValue + secondDice.faceValue {
            case 7, 11:
                balance += firstBet
                totalWL += firstBet
                firstBet = 0
                secondBet = 0
                return true
            case 2, 3, 12:
                balance -= firstBet
                totalWL -= firstBet
                firstBet = 0
                secondBet = 0
                return true
            default:
                targetPointToWinGame += firstDice.faceValue + secondDice.faceValue
                isFirstRoll = false
                return false
            }
        } else {
            switch firstDice.faceValue + secondDice.faceValue {
            case targetPointToWinGame:
                balance += firstBet + secondBet
                totalWL += firstBet + secondBet
                firstBet = 0
                secondBet = 0
                targetPointToWinGame = 0
                isFirstRoll = true
                return true
            case 7:
                balance -= firstBet + secondBet
                totalWL -= firstBet + secondBet
                firstBet = 0
                secondBet = 0
                targetPointToWinGame = 0
                isFirstRoll = true
                return true
            default:
                return false
            }
        }
    }
    
}
