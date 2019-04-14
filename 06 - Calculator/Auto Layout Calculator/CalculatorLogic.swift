//
//  CalculatorLogic.swift
//  Auto Layout Calculator
//
//  Created by Megan Brown on 4/7/19.
//  Copyright © 2019 Megan Brown. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    // this will create a brand-new struct with the updated value
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    // dependent upon the operator button pressed, output the result as an optional double
    mutating func calculate(symbol: String) -> Double? {
        if let n = number {
            switch symbol {
                case "+/-": return n * -1       // make number negative
                case "AC": return 0             // set number to 0 (clear)
                case "%": return n / 100        // make number a percentage
                case "=": return performTwoNumberCalculation(n2: n)
                                               // if an operator button is pressed
                default: intermediateCalculation = (n1: n, calcMethod: symbol)
            }
        }
        return nil
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            switch operation {
                case "+": return n1 + n2
                case "-": return n1 - n2
                case "÷": return n1 / n2
                case "x": return n1 * n2
                default: fatalError("The operation passed in does not match any of the cases")
            }
        }
        return nil
    }
}
