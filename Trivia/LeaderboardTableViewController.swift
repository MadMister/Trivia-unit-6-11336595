//
//  LeaderboardTableViewController.swift
//  Trivia
//
//  Created by Jan Marten Sevenster on 15/03/2018.
//  Copyright © 2018 John Appleseed. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LeaderboardTableViewController: UITableViewController {
    
    
    
    var player: Player?
    var players = [Player]()
    var sortedPlayers = [Player]()
    var rootRef : DocumentReference!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let rootReference = Firestore.firestore().collection("players")
        
        if let player = player {
            let JSONplayer : [String : Any] = ["name" : player.name, "score" : player.score]
            rootReference.addDocument(data: JSONplayer) { error in
                if let error = error {
                    print("mistakes were made in document \(error)")
                } else {
                    print("nice")
                }
            }
        }
        
        rootReference.getDocuments() { (snapshot, error) in
            if let error = error {
                print("mistakes weren made loading data from document \(error)")
            } else {
                for document in snapshot!.documents {
                    let name : String = document.data()["name"]! as! String
                    let score : Int = document.data()["score"]! as! Int
                    
                    let retrievedPlayer = Player(name : name, score : score)
                    self.players.append(retrievedPlayer)
                }
                self.sortedPlayers = self.players.sorted(by: {$0.score > $1.score})
                self.tableView.reloadData()
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let currentPlayer = sortedPlayers[indexPath.row]
        cell.textLabel?.text = currentPlayer.name
        cell.detailTextLabel?.text = String(currentPlayer.score)
    }
    
    /*
    func updateLeaderboard() {
        if let player = player {
            rootReference.child("players").childByAutoId().setValue(player)
        }
    }
    */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
