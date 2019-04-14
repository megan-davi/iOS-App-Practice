//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Created by Megan Brown on 1/7/19.
//  Copyright © 2019 Megan Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet var displayLabel: UILabel!
    
    // global variables only accessable to this class
    private var isFinishedTypingNumber = true
    private var calculator = CalculatorLogic()
    
    // displayValue is called ∴ cast result from a string to a double and update the display label
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a double")
            }
            return number
        } set {
            displayLabel.text = String(newValue)
        }
    }

    // one of the operator buttons are pressed ∴ make calls to the CalculatorLogic class and displayValue computed property
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
            
        }
    }
    
    // a number button is pressed ∴ append the value to the display label
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                // the period is pressed ∴ if the label is a double i.e. has a period already, do not append this value
                if numValue == "." {
                    let isInt = floor(displayValue) == displayValue
                    if !isInt {
                        return
                    }
                }
                displayLabel.text!.append(numValue)
            }
        }
    }
    
}

