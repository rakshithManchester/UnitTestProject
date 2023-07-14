//
//  MockCalendarViewController.swift
//  TeamsChatTests
//
//  Created by Appaiah on 06/07/23.
//

import XCTest
@testable import TeamsChat

final class CalendarViewControllerTest: XCTestCase {
    var calendarViewController: CalendarViewController!
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        calendarViewController = storyBoard.instantiateViewController(withIdentifier: "CalendarViewControllerNew") as? CalendarViewController
        calendarViewController.loadViewIfNeeded()
    }

    override func tearDown() {
       super.tearDown()
    }
    
    func testInitialisation() {
        XCTAssertNil(calendarViewController.customNavBar)
    }
    
    func testShowAlert() {
        //TODO: Test case shows i have covered 100% but is this right way to test function without return type.
        calendarViewController.showAlert("Tesing ShowAlert")
    }
    
    func testLocalized() {
        //TODO: Test case shows i have covered 100% but did not understand the working.
        let test = "testing"
        let localizedTest = test.localized()
    }
}
