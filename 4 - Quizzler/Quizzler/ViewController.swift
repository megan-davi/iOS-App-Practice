//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer = false
    var questionNumber = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    // once app has loaded, bring up the next (first) question
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
    }

    // runs when a user presses the true or false button
    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }
    
    // update the scoreboard, progress label, and progress bar
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 15"
        progressBar.frame.size.width = (view.frame.size.width / 15) * CGFloat(questionNumber + 1)
    }
    
    // advance to next question and update scoreboard or ask user to play again
    func nextQuestion() {
        if questionNumber <= 14 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all of the questions, do you want to play again?", preferredStyle: .alert)
            let restart = UIAlertAction(title: "Restart", style: .default, handler:
                {(UIAlertAction) in
                self.startOver()
            })
            alert.addAction(restart)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // compare correct answer to picked answer
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!")
            score -= 1
        }
    }
    
    // restart quiz
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
