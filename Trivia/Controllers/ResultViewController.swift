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
    
    
    @IBAction func nameFieldAltered(_ sender: UITextField) {
        updateConfirmButtonState()
    }
    
    var score: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score)
        updateConfirmButtonState()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "leaderboardSegue" {
            let navigationViewController = segue.destination as! UINavigationController
            let leaderboardTableViewController = navigationViewController.topViewController as! LeaderboardTableViewController
            leaderboardTableViewController.player!.name = nameField.text!
            leaderboardTableViewController.player!.score = score
        }
    }
    
    func updateConfirmButtonState() {
        let text = nameField.text ?? ""
        confirmButton.isEnabled = !text.isEmpty
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
