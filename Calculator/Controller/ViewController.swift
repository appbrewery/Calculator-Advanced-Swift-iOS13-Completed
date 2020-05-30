//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true
    private var calculator = CalculatorLogic()
    
    
    private var displayValue : Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert string to Double")
            }
            return number
        }
        set {
            let isInteger = floor(newValue) == newValue
            if isInteger {
                displayLabel.text = String(Int(newValue))
            } else {
            displayLabel.text = String(newValue)
            }
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        calculator.inputValue = displayValue
        if sender.currentTitle! == "+/-" || sender.currentTitle! == "%" {
            calculator.otherOps(operation: sender.currentTitle!)
        } else {
            calculator.calculate(operation: sender.currentTitle!)
        }
        displayValue = calculator.totalValue ?? 0
        
    }

    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numString = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numString
                isFinishedTypingNumber = false
                calculator.percentHasBeenUsed = false
                calculator.operatorLastTouched = false
            } else {
                if numString == "." {
                    if displayLabel.text!.contains(".") {
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + numString
            }
        }
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        // resets errrerything
        calculator.reset()
        isFinishedTypingNumber = true
        displayLabel.text = "0"
    }
    
}
