//
//  GameRulesViewController.swift
//  SevenEleven
//
//  Created by hunkar lule on 2018-12-06.
//  Copyright © 2018 hunkar lule. All rights reserved.
//

import UIKit

class GameRulesViewController: UIViewController {
    
    @IBOutlet weak var gameRulesTextview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gameRulesTextview.setContentOffset(.zero, animated: false)
    }
}
