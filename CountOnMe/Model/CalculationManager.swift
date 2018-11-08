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
    var total = 0.0
    
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
    func calculateWithPlusOrMinusOrMultiplyOrDivide(_ sign: String) {
        operators.append(sign)
        stringNumbers.append("")
    }
    
    func calculateTotal() {
       
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
    }
}


