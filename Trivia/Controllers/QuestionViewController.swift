//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Jan Marten Sevenster on 15/03/2018.
//  Copyright © 2018 John Appleseed. All rights reserved.
//
import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    var count = 0
    var score = 0
    let url = URL(string: "http://jservice.io/api/random")!

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    // outlets
    
    @IBAction func confirmButtonPressed() {
        next()
        if count < 5 {
            fetchRandomQuestion { (answer, question) in
                if let answer = answer, let question = question {
                    self.updateUI(with: answer, and: question)
                }
            }
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
        
    }
    
    @IBAction func passButtonPressed(_ sender: UIButton) {
        count = count + 1
        if count < 5 {
            fetchRandomQuestion { (answer, question) in
                if let answer = answer, let question = question {
                    self.updateUI(with: answer, and: question)
                }
            }
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
        
    }
    // IBActions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRandomQuestion { (answer, question) in
            if let answer = answer, let question = question {
                self.updateUI(with: answer, and: question)
            }
        }
    }
    // start with a random question

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.score = score
        }
    }
    // pas on score to the result screen
    
    func fetchRandomQuestion(completion: @escaping (String?, String?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let list = try? JSONSerialization.jsonObject(with: data) as! [[String: Any]] {
                
                let answer = String(describing: list[0]["answer"]!)
                let question = String(describing: list[0]["question"]!)
                completion(answer, question)
            }
        }
        task.resume()
    }
    // retrieve a question and the corresponding answer from the server
    
    func updateUI(with answer: String, and question: String) {
        DispatchQueue.main.async {
            self.answerLabel.text = answer
            self.questionLabel.text = question
            self.answerField.text = ""
            self.scoreLabel.text = String(describing: self.score)
        }
    }
    // update text in labels after question in retrieved
    
    func next() {
        if answerField.text == answerLabel.text {
            score += 1
        } else {
            score -= 1
        }
        count += 1
    }
    // keep track of score and question number

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
