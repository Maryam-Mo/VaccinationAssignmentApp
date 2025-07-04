//
//  AddDoseTests.swift
//  VaccinationApp
//
//  Created by Maryam on 7/4/25.
//

import XCTest

class AddDoseTests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAddingADoseUpdatesDetailAndCount() throws {
        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()

        let addDoseButton = app.buttons["addDoseButton"]
        XCTAssertTrue(addDoseButton.waitForExistence(timeout: 5))

        addDoseButton.tap()

        let doseButton = app.buttons["dosePickerButton"]
        XCTAssertTrue(doseButton.waitForExistence(timeout: 5))
        doseButton.tap()
        let dos2 = app.buttons["Dos 2"]
        XCTAssertTrue(dos2.waitForExistence(timeout: 5))
        dos2.tap()

        let dateField = app.textFields["dateField"]
        XCTAssertTrue(dateField.waitForExistence(timeout: 5))
        dateField.tap()

        let doneButton = app.toolbars.buttons["Klar"]
        XCTAssertTrue(doneButton.waitForExistence(timeout: 5))
        doneButton.tap()

        let saveButton = app.buttons["saveButton"]
        XCTAssertTrue(saveButton.isEnabled)
        saveButton.tap()

        let newDoseRow = app.staticTexts["Dos 2"]
        XCTAssertTrue(newDoseRow.waitForExistence(timeout: 2))

        let sectionLabel = app.staticTexts.matching(identifier: "sectionLabel").firstMatch
        XCTAssertTrue(sectionLabel.exists)
    }
}
