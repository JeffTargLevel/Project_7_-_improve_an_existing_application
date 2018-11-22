//
//  CalculateManagerTests.swift
//  CountOnMeTests
//
//  Created by Jean-François Santolaria on 08/10/2018.
//  Copyright © 2018 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculationManagerTests: XCTestCase {

    var calculationManager: CalculationManager!
    
    override func setUp() {
        super.setUp()
        calculationManager = CalculationManager()
    }
    
    private func doTheFollowingCalculation(_ number1: Int, _ sign: String, _ number2: Int) {
        calculationManager.addNewNumber(number1)
        calculationManager.calculateWithPlusOrMinusOrMultiplyOrDivide(sign)
        calculationManager.addNewNumber(number2)
        calculationManager.calculateTotal()
    }
    
    func testGivenToDoThreePlusThree_WhenUsePlusSign_ThenTheResultIsSix() {
        doTheFollowingCalculation(3, "+", 3)
        
        XCTAssertEqual(calculationManager.total, 6)
    }
    
    func testGivenToDoSixMinusSix_WhenUseMinusSign_ThenTheResultIsZero() {
        doTheFollowingCalculation(6, "-", 6)
        
        XCTAssertEqual(calculationManager.total, 0)
    }
    
    func testGivenToDoTenMultiplyTwo_WhenUseMultiplySign_ThenTheResultIsTwenties() {
        doTheFollowingCalculation(10, "×", 2)
        
        XCTAssertEqual(calculationManager.total, 20)
    }
    
    func testGivenToDoTwelveDivideByThree_WhenUseDivideSign_ThenTheResultIsFour() {
        doTheFollowingCalculation(12, "÷", 3)
        
        XCTAssertEqual(calculationManager.total, 4)
    }
    
    func testGivenToDoSevenDivideByZero_WhenUseDivideSign_ThenTheResultIsInfinity() {
        doTheFollowingCalculation(7, "÷", 0)
        
        XCTAssertEqual(calculationManager.total, .infinity)
        XCTAssertEqual(calculationManager.IsNotDivideByZero, true)
    }
}
