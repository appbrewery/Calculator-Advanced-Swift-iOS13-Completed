import Foundation

struct CalculatorLogic {
    
    var totalValue: Double?
    private var storedValue: Double?
    private var storedOp: String?
    private var storedOpForReturn: String?
    var inputValue: Double = 0
    
    var operatorLastTouched: Bool = false
    var percentHasBeenUsed: Bool = false
    
    mutating func reset() {
        totalValue = nil
        storedValue = nil
        storedOp = nil
        inputValue = 0
        operatorLastTouched = false
        percentHasBeenUsed = false
    }
    
    mutating func math(passOp: String, inputOrStoredValue: Double) {
        switch passOp {
        case "÷":
            totalValue = totalValue! / inputOrStoredValue
        case "×":
            totalValue = totalValue! * inputOrStoredValue
        case "-":
            totalValue = totalValue! - inputOrStoredValue
        case "+":
            totalValue = totalValue! + inputOrStoredValue
        case "=":
            return
        default:
            return
        }
    }
    
    mutating func calculate(operation: String) {
        // when user clicks an operate button the first time
        // 12 +
        if totalValue == nil {
            totalValue = inputValue
            storedOp = operation
            inputValue = 0
            return
        }
        // following should only go through if the SAME op is pressed twice in a row.
        if operatorLastTouched {
            if storedOp == operation {
                if storedOp == "=" {
                    math(passOp: storedOpForReturn!, inputOrStoredValue: storedValue!)
                } else {
                math(passOp: operation, inputOrStoredValue: storedValue!)
                }
            } else {
                return
            }
        } else {
            operatorLastTouched = true
            // stores the current input value and operation in case the user
            // wants to repeat the Operation.
            math(passOp: storedOp!, inputOrStoredValue: inputValue)
            if operation == "=" {
                storedOpForReturn = storedOp
                storedOp = operation
            } else {
                storedOp = operation
            }
            storedValue = inputValue
        }
        
    }
    
    mutating func otherOps(operation: String) {
        // having this in the same function as the math makes a conflict
        // with "operatorLastTouched" so you can't use this
        // after you hit an operator.
        // (like if you hit divide when you meant to hit percent)
        // keeping it separated solves this issue
        switch operation {
        case "+/-":
            totalValue = totalValue! * -1
        case "%" :
            if percentHasBeenUsed {
                return
            }
            totalValue = inputValue * 0.01
            percentHasBeenUsed = true
        default:
            return
        }
    }
}
