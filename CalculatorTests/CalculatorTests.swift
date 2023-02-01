//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Иван Степанов on 31.01.2023.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let calculatorViewModel = CalculatorViewModel()
        calculatorViewModel.calculationActionsArray = ["2", "x", "3"]
        calculatorViewModel.signSwitchAndCalculation()
        XCTAssert(calculatorViewModel.calculationActionsArray[0] == "6")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
