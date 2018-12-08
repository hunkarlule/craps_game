//
//  ViewController.swift
//  SevenEleven
//
//  Created by hunkar lule on 2018-11-13.
//  Copyright © 2018 hunkar lule. All rights reserved.
//

import UIKit
import AVFoundation

class SevenElevenGameViewController: UIViewController {
    
    var game = Game()
    
    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var secondDiceView: DiceView!
    @IBOutlet weak var firstDiceView: DiceView!
    @IBOutlet weak var firstBetAmount: UILabel!
    @IBOutlet weak var secondBetAmount: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var totalWL: UILabel!
    @IBOutlet var firstRollDiceTotal: [UIButton]!
    var firstBet: Int {
        get { return game.firstBet }
        
        set {
            if newValue == 0 {
                rollButton.isEnabled = false
            } else {
                rollButton.isEnabled = true
            }
        }
    }
    private var totalBetAmount = 0 {
        willSet {
            if newValue > game.balance {
                let ac = UIAlertController(title: "Chips", message: "You do not have enough chips for this bet! Please buy chips or try another bet!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            } else if newValue > game.maxBetAllowed {
                let ac = UIAlertController(title: "Max Bet!", message: "Your bet is exceeding max bet limit. Alloved max bet is \(game.maxBetAllowed).", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }  
        }
    }
    
    @IBAction func bet(_ sender: UIButton) {
        let start = String.Index(encodedOffset: 0)
        let end = String.Index(encodedOffset: sender.currentTitle!.count - 1)
        let substring = String(sender.currentTitle![start..<end])
        let betAmount = Int(substring)!
        totalBetAmount = betAmount + game.firstBet + game.secondBet
        if totalBetAmount <= game.maxBetAllowed , totalBetAmount <= game.balance {
            game.setBets(amount: betAmount)
            firstBet = game.firstBet
            firstBetAmount.text = "\(firstBet)$"
            secondBetAmount.text = "\(game.secondBet)$"
        }
    }
    
    @IBAction func roll(_ sender: UIButton) {
        game.roll()
        firstDiceView.faceValue = game.firstDice.faceValue
        secondDiceView.faceValue = game.secondDice.faceValue
        
        
        if game.isFirstRoll {
            let index = firstRollDiceTotal.filter({ (button) -> Bool in
                return Int(button.currentTitle!) == game.firstDice.faceValue + game.secondDice.faceValue
            })
            index.first?.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
        
        if game.checkGameResult() {
            firstBetAmount.text = "\(game.firstBet)$"
            secondBetAmount.text = "\(game.secondBet)$"
            balance.text = "\(game.balance)$"
            totalWL.text = "\(game.totalWL)$"
            for button in firstRollDiceTotal {
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            UserDefaults.standard.set(game.balance, forKey: "Balance")
            firstBet = game.firstBet
        }
        
        if game.targetPointToWinGame == 0 {
            
        }
    }
    var audioPlayer: AVAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        game.balance = UserDefaults.standard.integer(forKey: "Balance")
        switch UserDefaults.standard.integer(forKey: Settings.Background.rawValue) {
        case 0: view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case 1: view.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        default: break
        }
        
        if UserDefaults.standard.bool(forKey: Settings.Sound.rawValue) {
            playSound()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch UserDefaults.standard.integer(forKey: Settings.Background.rawValue) {
        case 0: view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case 1: view.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        default: break
        }
        
        balance.text = String(UserDefaults.standard.integer(forKey: "Balance"))
        rollButton.isEnabled = false
    }
    
    private func playSound() {
        if let path = Bundle.main.path(forResource: "bensound-thelounge", ofType: ".mp3") {
            let url = URL(fileURLWithPath: path)
            audioPlayer = try? AVAudioPlayer(contentsOf: url)
            
        }
        if let player = audioPlayer {
            player.numberOfLoops = -1
            player.play()
        }
    }
}
