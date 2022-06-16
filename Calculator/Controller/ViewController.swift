//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//  Updated by OsamaSaberB
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Cannot convert display label text to a Double.")
            }
            return number
        }
        set {
            
            // To prevent AC button from showing displayLabel.text as "0.0" and display int "0" instead
            if String(newValue) != "0.0" {
                
                displayLabel.text = String(format: newValue.removeZerosFromEnd())
                
            } else {
                displayLabel.text = "0"
            }
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
 
            if let result = calculator.calculate(symbol: calcMethod) {
                displayValue = result
            }
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                
                //To prevent display label from showing only "." as first character and display "0." instead
                if numValue == "." && displayLabel.text?.first != "." {
                    displayLabel.text = "0."
                    isFinishedTypingNumber = false
                    return
                }
                displayLabel.text = numValue
                isFinishedTypingNumber = false
                
            } else {
                
                if numValue == "." {
                    
                    // to prevent the addision of another (.)
                    if displayLabel.text!.contains(".") {
                        return
                    } else {
                        let isInt = floor(displayValue) == displayValue // Bool expresion
                        if !isInt {
                            return
                        }
                    }
                    
                } // end if numValue
                displayLabel.text = displayLabel.text! + numValue
            }
        }
    }

}

// extension to remove trailing zeros from an integer result
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
