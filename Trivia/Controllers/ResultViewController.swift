//
//  ResultViewController.swift
//  Trivia
//
//  Created by Jan Marten Sevenster on 17/03/2018.
//  Copyright © 2018 John Appleseed. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    // outlets
    
    @IBAction func nameFieldAltered(_ sender: UITextField) {
        updateConfirmButtonState()
    }
    // IBActions
    
    var score: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score)
        updateConfirmButtonState()
    }
    // fill in score and disable confirm button

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeaderboardSegueFromResults" {
            let navigationViewController = segue.destination as! UINavigationController
            let leaderboardTableViewController = navigationViewController.topViewController as! LeaderboardTableViewController
            leaderboardTableViewController.player = Player(name: nameField.text!, score: score)
        }
    }
    // pass on player data to leaderboard
    
    func updateConfirmButtonState() {
        let text = nameField.text ?? ""
        confirmButton.isEnabled = !text.isEmpty
    }
    // enable confirm button if name is entered

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
