//
//  CalculationManager.swift
//  CountOnMe
//
//  Created by Jean-François Santolaria on 04/10/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import Foundation
import UIKit

class CalculationManager {
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    
    func addNewNumberAndDisplay(_ newNumber: Int, _ stringNumber: UITextView) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        updateDisplay(stringNumber)
    }
    
    func calculateWithPlusOrMinusOrMultiplyOrDivide(_ sign: String) {
        operators.append(sign)
        stringNumbers.append("")
    }
    
    func calculateAndDiplayTotal(total view: UITextView) {
        var total = 0.0
        
        for (index, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if operators[index] == "+" {
                    total += number
                } else if operators[index] == "-" {
                    total -= number
                } else if operators[index] == "×" {
                    total *= number
                } else if operators[index] == "÷" {
                    total /= number
                }
            }
        }
        view.text += "=\(total)"
        clearDisplay()
    }
}

// MARK: - Update and clear display

extension CalculationManager {
    
    func updateDisplay(_ textView: UITextView) {
        var text = String()
        for (index, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += operators[index]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }
    
    func clearDisplay() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
}
