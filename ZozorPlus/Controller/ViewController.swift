//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculationManager = CalculationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        textView.text = ""
    }
    
    var isExpressionCorrect: Bool {
        if let stringNumber = calculationManager.stringNumbers.last, stringNumber.isEmpty {
            if calculationManager.stringNumbers.count == 1 {
                    alertControllerWithMessage("Démarrez un nouveau calcul !")
                } else {
                   alertControllerWithMessage("Entrez une expression correcte !")
                }
                return false
        }
        return true
    }
    
    func alertControllerWithMessage(_ message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    var canAddOperator: Bool {
        if let stringNumber = calculationManager.stringNumbers.last {
            if stringNumber.isEmpty {
                alertControllerWithMessage("expression incorrecte !")
                return false
            }
        }
        return true
    }
}

// MARK: - Buttons operations

extension ViewController {
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                calculationManager.addNewNumberAndDisplay(i, textView)
            }
        }
    }
    
    @IBAction func plus() {
        if canAddOperator {
            calculationManager.calculateWithPlusOrMinus("+")
            calculationManager.updateDisplay(textView)
        }
    }
    
    @IBAction func minus() {
        if canAddOperator {
            calculationManager.calculateWithPlusOrMinus("-")
            calculationManager.updateDisplay(textView)
        }
    }
    
    @IBAction func equal() {
        if isExpressionCorrect {
        calculationManager.calculateAndDiplayTotal(total: textView)
        }
    }
}
