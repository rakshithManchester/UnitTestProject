//
//  MockConversationsViewController.swift
//  TeamsChatTests
//
//  Created by Appaiah on 06/07/23.
//

import XCTest
@testable import TeamsChat

final class ConversationsViewControllerTest: XCTestCase {
    var conversationsViewController: ConversationsViewController!
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        conversationsViewController = storyBoard.instantiateViewController(withIdentifier: "ConversationsViewController") as? ConversationsViewController
        conversationsViewController.loadViewIfNeeded()
    }
    
    override func tearDown()  {
        conversationsViewController = nil
        super.tearDown()
    }
    
    func testTableviewNotNil() {
        XCTAssertNotNil(conversationsViewController.tblConversation)
        XCTAssertNotNil(conversationsViewController.tblConversation.dataSource)
        XCTAssertNotNil(conversationsViewController.tblConversation.delegate)
        XCTAssertTrue(conversationsViewController.tblConversation.delegate is ConversationsViewController)
        XCTAssertTrue(conversationsViewController.tblConversation.dataSource is ConversationsViewController)
    }
    
    func testTableviewHeightForRow_SectionZero() {
        let indePath = IndexPath(row: 0, section: 0)
        let height = conversationsViewController.tableView(conversationsViewController.tblConversation, heightForRowAt: indePath)
        XCTAssertEqual(height, 100.0,"table view height should be 100.0")
    }
    
    func testTableviewHeightForRow_SectionNotZero() {
        let indePath = IndexPath(row: 0, section: 1)
        let height = conversationsViewController.tableView(conversationsViewController.tblConversation, heightForRowAt: indePath)
        XCTAssertEqual(height, 65.0,"table view height should be 65.0")
    }
    
    func testEstimatedHeightForRowAt() {
        let indePath = IndexPath(row: 0, section: 1)
        let estimatedHeightForRowAt = conversationsViewController.tableView(conversationsViewController.tblConversation, estimatedHeightForRowAt: indePath)
        XCTAssertEqual(estimatedHeightForRowAt, 64.0, "table view Row height should be 65.0")
    }
    
    func testNumberOfSections() {
        let sectionCount = conversationsViewController.numberOfSections(in: conversationsViewController.tblConversation)
        XCTAssertEqual(sectionCount, 2)
    }

    func testNumberOfRowsInSection_SectionZero() {
        let numberOfRows = conversationsViewController.tableView(conversationsViewController.tblConversation, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1)
        //1. TODO mock ChatViewModel
    }
    
    func testNumberOfRowsInSection_SectionNotZero() {
        let numberOfRows = conversationsViewController.tableView(conversationsViewController.tblConversation, numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfRows, 10)
    }
    
    func testCellForRowAt_SectionZero() {
        let indePath = IndexPath(row: 0, section: 0)
        let recentChatTableViewCell = conversationsViewController.tableView(conversationsViewController.tblConversation, cellForRowAt: indePath)
        XCTAssertTrue(recentChatTableViewCell is RecentChatTableViewCell)
    }
    
    func testCellForRowAt_SectionOne() {
        let indePath = IndexPath(row: 0, section: 1)
        let ReusableConversationTableViewCell = conversationsViewController.tableView(conversationsViewController.tblConversation, cellForRowAt: indePath)
        XCTAssertTrue(ReusableConversationTableViewCell is ReusableConversationTableViewCell)
    }
    
    func testNumberOfRowsInSection_SectionOne_ChatViewModelNil() {
        conversationsViewController.chatVM = nil
        let numberOfRows = conversationsViewController.tableView(conversationsViewController.tblConversation, numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfRows, 0,"chatVM is nil")
    }
    
    func testNumberOfRowsInSection_SectionOneo_EmptyChatList() {
        let chatViewModelMock = ChatViewModelMock()
        let chatList = chatViewModelMock.getEmptyChatList()
        conversationsViewController.chatVM?.chatlist = chatList
        let numberOfRows = conversationsViewController.tableView(conversationsViewController.tblConversation, numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfRows, 0,"chatlist is 0")
    }
    
    func testDidSelectRowAt() {
        let indePath = IndexPath(row: 0, section: 0)
        conversationsViewController.tableView(conversationsViewController.tblConversation,
                                              didSelectRowAt: indePath)
        let naviagtionTopVC = conversationsViewController.navigationController
        XCTAssertNil(naviagtionTopVC)
    }
    
    func test_ReusableConversationTableViewCell_setSelected() {
        let indePath = IndexPath(row: 0, section: 0)
        let reusableConversationTableViewCell = conversationsViewController.tableView(conversationsViewController.tblConversation, cellForRowAt: indePath)
        XCTAssertTrue(reusableConversationTableViewCell is RecentChatTableViewCell)
    }
    
    func testCustomNavigationBar_isLeftButtonHidden() {
        conversationsViewController.customNavigationBar.isLeftButtonHidden = true
        XCTAssertEqual(conversationsViewController.customNavigationBar.isLeftButtonHidden, true)
    }
    
    func testCustomNavigationBar_isRightFirstButtonEnabled() {
        conversationsViewController.customNavigationBar.isRightFirstButtonEnabled = true
        XCTAssertEqual(conversationsViewController.customNavigationBar.isRightFirstButtonEnabled, true)
    }
}
