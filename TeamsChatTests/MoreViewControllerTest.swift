//
//  MockUIViewControllerExtensions.swift
//  TeamsChatTests
//
//  Created by Appaiah on 06/07/23.
//

import XCTest
@testable import TeamsChat

final class MoreViewControllerTest: XCTestCase {
    var moreViewController: MoreViewController!
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        moreViewController = storyBoard.instantiateViewController(identifier: "MoreViewController") as? MoreViewController
        moreViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialisation() {
        XCTAssertNotNil(moreViewController)
    }
}
