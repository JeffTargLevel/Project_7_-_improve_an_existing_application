//
//  CalculateManagerTests.swift
//  CountOnMeTests
//
//  Created by Jean-François Santolaria on 08/10/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculateManagerTests: XCTestCase {

    var calculationManager: CalculationManager!
    
    override func setUp() {
        super.setUp()
        calculationManager = CalculationManager()
    }
    
    private func doTheFollowingCalculation(_ number1: Int, _ sign: String, _ number2: Int) {
        calculationManager.addNewNumberAndDisplay(number1, UITextView())
        calculationManager.calculateWithPlusOrMinusOrMultiplyOrDivide(sign)
        calculationManager.addNewNumberAndDisplay(number2, UITextView())
        calculationManager.calculateAndDiplayTotal(total: UITextView())
    }
    
    func testGivenToDoThreePlusThree_WhenUseSignPlus_ThenTheResultIsSix() {
        doTheFollowingCalculation(3, "+", 3)
        
        XCTAssertEqual(calculationManager.total, 6)
    }
    
    func testGivenToDoSixMinusSix_WhenUseSignMinus_ThenTheResultIsZero() {
        doTheFollowingCalculation(6, "-", 6)
        
        XCTAssertEqual(calculationManager.total, 0)
    }
    
    func testGivenToDoTenMultiplyTwo_WhenUseSignMultiply_ThenTheResultIsTwenties() {
        doTheFollowingCalculation(10, "×", 2)
        
        XCTAssertEqual(calculationManager.total, 20)
    }
    
    func testGivenToDoTwelveDivideThree_WhenUseSignDivide_ThenTheResultIsFour() {
        doTheFollowingCalculation(12, "÷", 3)
        
        XCTAssertEqual(calculationManager.total, 4)
    }
}
