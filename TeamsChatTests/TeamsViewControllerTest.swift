//
//  MockTeamsViewController.swift
//  TeamsChatTests
//
//  Created by Appaiah on 06/07/23.
//

import XCTest
@testable import TeamsChat

final class TeamsViewControllerTest: XCTestCase {
    var teamsViewController: TeamsViewController!
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        teamsViewController = storyBoard.instantiateViewController(withIdentifier: "TeamsViewController") as? TeamsViewController
        teamsViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialisation() {
        XCTAssertNotNil(teamsViewController.customNavBar)
    }

}
