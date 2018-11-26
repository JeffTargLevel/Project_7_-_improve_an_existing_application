//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    
    @IBOutlet weak private var plusOrMultiplyButton: UIButton!
    @IBOutlet weak private var minusOrDivideButton: UIButton!
    
    private var calculationManager = CalculationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        longPressGestureRecognizerOnPlusOrMultiplyButton()
        longPressGestureRecognizerOnMinusOrDivideButton()
    }
    
    private func setupUI() {
        textView.text = ""
    }
}

// MARK: - Configure alertController

extension CalculatorViewController {
    
    private func alertControllerWithMessage(_ message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - Configure press signs buttons

extension CalculatorViewController {
    
    private func longPressGestureRecognizerOnPlusOrMultiplyButton() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(configurePressPlusOrMultiplyButton(_:)))
        plusOrMultiplyButton.addGestureRecognizer(longGesture)
    }
    
    private func longPressGestureRecognizerOnMinusOrDivideButton() {
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(configurePressMinusOrDivideButton(_:)))
        minusOrDivideButton.addGestureRecognizer(longGesture)
    }
    
    private func changeColorButton(_ button: UIButton, _ color: UIColor) {
        button.backgroundColor = color
        button.tintColor = color
    }
    
    private func transformButtonSign(_ sender: UILongPressGestureRecognizer, _ button: UIButton, _ sign: String) {
        button.isSelected = true
        changeColorButton(button, #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1))
        addOperator(sign)
    }
    
    @objc private func configurePressPlusOrMultiplyButton(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            transformButtonSign(sender, plusOrMultiplyButton, "×")
        case .ended, .cancelled:
            plusOrMultiplyButton.isSelected = false
            changeColorButton(plusOrMultiplyButton, #colorLiteral(red: 0.4705882353, green: 0.7137254902, blue: 0.6235294118, alpha: 1))
        default:
            break
        }
    }
    
    @objc private func configurePressMinusOrDivideButton(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            transformButtonSign(sender, minusOrDivideButton, "÷")
        case .ended, .cancelled:
            minusOrDivideButton.isSelected = false
            changeColorButton(minusOrDivideButton, #colorLiteral(red: 0.8745098039, green: 0.3725490196, blue: 0.3254901961, alpha: 1))
        default:
            break
        }
    }
}

//MARK: - Select number, add operator and prepare for result

extension CalculatorViewController {
    
    private func selectNumber(_ sender: UIButton) {
        for (indexNumber, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                calculationManager.addNewNumber(indexNumber)
                updateDisplay(textView)
            }
        }
    }
    
    private func addOperator(_ sign: String) {
        if calculationManager.canAddOperator {
            calculationManager.calculateWithPlusOrMinusOrMultiplyOrDivide(sign)
            updateDisplay(textView)
        } else {
            alertControllerWithMessage("Expression incorrecte !")
        }
    }
    
    private var isReadyForOperation: Bool {
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
    
    private func readyForResult() {
        if isReadyForOperation {
            calculationManager.calculateTotal()
            displayTotal(textView)
            clearDisplay()
        }
    }
}

// MARK: - Update, total and clear display

extension CalculatorViewController {
    
    private func updateDisplay(_ textView: UITextView) {
        var text = String()
        
        for (index, stringNumber) in calculationManager.stringNumbers.enumerated() {
            // Add operator
            if index > 0 {
                text += calculationManager.operators[index]
            }
            // Add number
            text += stringNumber
        }
        textView.text = text
    }
    
    private func displayTotal(_ view: UITextView) {
        if !calculationManager.IsNotDivideByZero {
            view.text += "=\(calculationManager.total)"
        } else {
            alertControllerWithMessage("Erreur")
        }
    }
    
    private func clearDisplay() {
        calculationManager.stringNumbers = [String()]
        calculationManager.operators = ["+"]
        calculationManager.total = 0.0
    }
}

// MARK: - Buttons operations

extension CalculatorViewController {
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        selectNumber(sender)
    }
    
    @IBAction func plus() {
        addOperator("+")
    }
    
    @IBAction func minus() {
        addOperator("-")
    }
    
    @IBAction func equal() {
        readyForResult()
    }
}
