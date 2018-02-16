//
//  ViewController.swift
//  Apple Pie
//
//  Created by Philip van der Hoek on 13/02/2018.
//  Copyright © 2018 Philip van der Hoek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["food", "names", "hobbies", "animals", "dogs", "bed", "computer"]
    let incorrectMovesAllowed = 7
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    var currentGame: Game!
    
    var totalWins = 0 {
        // Keeps count of wins
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        // Keeps count of losses
        didSet {
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func newRound() {
        // Initiates new round
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord,
                               incorrectMovesRemaining: incorrectMovesAllowed,
                               guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {
        // Updates the image etc
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        _ = letters.joined(separator: " ")
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Checks if button is pressed and acts accordingly
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateUI()
        updateGameState()
    }
    
    func updateGameState() {
        // Checks for win or loss
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        // Resets buttons
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

