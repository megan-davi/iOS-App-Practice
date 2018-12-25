//
//  ViewController.swift
//  Dicee
//
//  Created by Marshall Davi on 12/25/18.
//  Copyright © 2018 megan-davi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0

    @IBOutlet weak var diceImageView1: UIImageView!
    
    @IBOutlet weak var diceImageView2: UIImageView!
    
    // Runs upon app loading
    override func viewDidLoad() {
        super.viewDidLoad()

        updateDiceImages()
    }
    
    // Runs when the roll button is pressed
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        updateDiceImages()
    }
    
    // Triggered when the phone has finished shaking
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
    // Method to update dice images to a random face
    func updateDiceImages(){
        // Generate a random number between 0 and 5 (total = 6)
        randomDiceIndex1 = Int.random(in: 0 ... 5)
        randomDiceIndex2 = Int.random(in: 0 ... 5)
        
        // Change the dice view image to the random number
        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
    }
    
}

