//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Иван Степанов on 01.02.2023.
//

import Foundation
import SwiftUI
import BTCGetter

final public class CalculatorViewModel: ObservableObject{
    
    @Published var calculationActionsArray: [String] = []
    @Published var calculationText = "0"
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    var calculatorButtonsTitles = ["C", "sin", "cos", "÷", "1", "2", "3", "x", "4", "5", "6", "-", "7", "8", "9", "+", "0", "₿", ".", "="]
    let operationButtons: [Int] = [1, 2, 3, 7, 11, 15, 19]
    let operationSigns: [String] = ["÷", "x", "+", "-"]
    
    func calculationFunction(in buttonNumber: Int){
        // Check if the buttonNumber is 0
        if buttonNumber == 0 {
            // If the buttonNumber is 0, set the calculationText to "0" and reset the calculationActionsArray
            calculationText = "0"
            calculationActionsArray = []
            // Return immediately to prevent further execution
            return
        }
        // Check if the buttonNumber is an operation button
        else if operationButtons.contains(buttonNumber) {
            // If the buttonNumber is an operation button, call the handleOperationButton function
            handleOperationButton(buttonNumber)
        }
        // Check if the buttonNumber is equal to 17
        else if buttonNumber == 17 {
            // If the buttonNumber is equal to 17, call the fetchBTCPrice function
            fetchBTCPrice()
        }
        // If the buttonNumber is not 0, an operation button, or equal to 17
        else {
            // Call the handleNumberButton function
            handleNumberButton(buttonNumber)
        }

    }
    
    
    
    // function that performs calculation based on operator stored in calculationActionsArray[1]
    func signSwitchAndCalculation(){
        switch calculationActionsArray[1] {
        case "÷":
            // handle division by 0 error
            if calculationActionsArray[2] == "0" {
                // update calculationText in main thread to show the error message
                DispatchQueue.main.async {
                    self.calculationText = "Error: Division by zero"
                }
                return
            }
            // perform division and store result in calculationActionsArray
            calculationActionsArray = [doubleToIntOrDouble(doubleValue: Double(calculationActionsArray[0])! / Double(calculationActionsArray[2])!)]
        case "x":
            // perform multiplication and store result in calculationActionsArray
            calculationActionsArray = [doubleToIntOrDouble(doubleValue: Double(calculationActionsArray[0])! * Double(calculationActionsArray[2])!)]
        case "-":
            // perform subtraction and store result in calculationActionsArray
            calculationActionsArray = [doubleToIntOrDouble(doubleValue: Double(calculationActionsArray[0])! - Double(calculationActionsArray[2])!)]
        case "+":
            // perform addition and store result in calculationActionsArray
            calculationActionsArray = [doubleToIntOrDouble(doubleValue: Double(calculationActionsArray[0])! + Double(calculationActionsArray[2])!)]
        default:
            // default case to handle unexpected situations
            print("default")
        }
    }
    
    // This function takes in a Double value and converts it to either an integer (if the value is rounded and has no decimal) or a string representation of the Double value.
    func doubleToIntOrDouble(doubleValue: Double) -> String {
        // Round the Double value
        let rounded = round(doubleValue)
        
        // Calculate the decimal difference between the original Double value and the rounded value
        let decimal = rounded - doubleValue
        
        // If the decimal difference is 0, it means that the Double value can be converted to an integer
        if decimal == 0 {
            // Return the integer value as a string
            return String(Int(rounded))
        }
        
        // If the decimal difference is not 0, return the string representation of the Double value
        return String(format: "%.2f", doubleValue)
    }
    
    func handleOperationButton(_ buttonNumber: Int) {
        // Check if buttonNumber is 1 or 2
        if buttonNumber == 1 || buttonNumber == 2 {
            // Convert the calculationText to radians and store it in a radians constant
            let radians = Double(calculationText)! * .pi / 180
            
            // Set the calculationText to either the sine or cosine of the radians
            // depending on the value of buttonNumber.
            calculationText = String(format: "%.1f", (buttonNumber == 1) ? sin(radians) : cos(radians))
        } else {
            // Check if the last element in the calculationActionsArray is one of the
            // operation signs and the calculationText is "0" and the buttonNumber is not 19
            if operationSigns.contains(calculationActionsArray.last ?? "") && calculationText == "0" && buttonNumber != 19 {
                // If the conditions are met, replace the last element in the calculationActionsArray
                // with the title of the current buttonNumber
                calculationActionsArray[calculationActionsArray.count - 1] = calculatorButtonsTitles[buttonNumber]
            } else {
                // Add the calculationText to the calculationActionsArray
                calculationActionsArray.append(calculationText)
                
                // Check if there are at least two elements in the calculationActionsArray
                if calculationActionsArray.count >= 2 {
                    // Perform the signSwitchAndCalculation function
                    signSwitchAndCalculation()
                    
                    // Check if the buttonNumber is 19
                    if buttonNumber == 19 {
                        // If it is, set the calculationText to the first element in the calculationActionsArray
                        // and clear the calculationActionsArray
                        calculationText = calculationActionsArray[0]
                        calculationActionsArray = []
                    }
                }
                
                // Check if the buttonNumber is not 19
                if buttonNumber != 19 {
                    // If it is not, add the title of the current buttonNumber to the calculationActionsArray
                    // and reset the calculationText to "0"
                    calculationActionsArray.append(calculatorButtonsTitles[buttonNumber])
                    calculationText = "0"
                }
            }
        }

    }

    func handleNumberButton(_ buttonNumber: Int) {
        // Check if the calculationText is equal to "0".
        if calculationText == "0"{
            // If it is, replace the calculationText with the title of the button represented by buttonNumber.
            calculationText = calculatorButtonsTitles[buttonNumber]
        } else {
            // If not, concatenate the title of the button represented by buttonNumber to the existing calculationText.
            calculationText += calculatorButtonsTitles[buttonNumber]
        }
    }

    func fetchBTCPrice() {
        // getBTCPrice is a function that takes in a completion closure as an argument.
        // The closure takes in a single parameter, priceString, and returns void.

        getBTCPrice { (priceString) in
            // if the returned priceString is not nil, update calculationText with the value of priceString
            if let priceString = priceString {
                // access the main queue to update the calculationText property of the object (likely a view controller)
                DispatchQueue.main.async {
                    self.calculationText = priceString
                }
            } else {
                // if the returned priceString is nil, set the calculationText property to an error message
                self.calculationText = "Error fetching the value of Bitcoin"
            }
        }

    }
    
    func buttonSize(_ geometry: GeometryProxy) -> CGFloat {
        // Check if the screen width is greater than or equal to 700
        if UIScreen.main.bounds.width >= 700 {
            // If true, return a button width equal to 1/6 of the screen width
            return geometry.size.width / 6
        } else {
            // If false, return a button width equal to 1/5 of the screen width
            return geometry.size.width / 5
        }
    }
}



