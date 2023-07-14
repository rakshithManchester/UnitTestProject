//
//  MockCallsViewController.swift
//  TeamsChatTests
//
//  Created by Appaiah on 06/07/23.
//

import XCTest
@testable import TeamsChat

final class CallsViewControllerTest: XCTestCase {
    var mockCallsViewController: CallsViewController!
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        mockCallsViewController = storyBoard.instantiateViewController(withIdentifier: "CallsViewController") as? CallsViewController
        mockCallsViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
    }
   
    func testInitialisation() {
        XCTAssertNotNil(mockCallsViewController.customNavBar)
    }

}
