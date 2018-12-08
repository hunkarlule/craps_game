//
//  SettingsTableViewController.swift
//  SevenEleven
//
//  Created by hunkar lule on 2018-12-06.
//  Copyright © 2018 hunkar lule. All rights reserved.
//

import UIKit

enum Settings: String {
    case Sound = "sound"
    case Background = "background"
}

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var settingsSwitch: UISwitch!
    @IBOutlet weak var configSegmentedControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If you need to set default values
        defaults.register(defaults: [Settings.Sound.rawValue : true])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        settingsSwitch?.isOn = defaults.bool(forKey: Settings.Sound.rawValue)
        configSegmentedControl.selectedSegmentIndex = defaults.integer(forKey: Settings.Background.rawValue)
    }
    
    @IBAction func notificationChange(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: Settings.Sound.rawValue)
    }
    
    @IBAction func configurationChange(_ sender: UISegmentedControl) {
        defaults.set(sender.selectedSegmentIndex, forKey: Settings.Background.rawValue)
    }
}
