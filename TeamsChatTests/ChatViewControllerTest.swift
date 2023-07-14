//
//  MockChatViewController.swift
//  TeamsChatTests
//
//  Created by Appaiah on 06/07/23.
//

import XCTest
@testable import TeamsChat

final class ChatViewControllerTest: XCTestCase {
    var chatViewController: ChatViewController!
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        chatViewController = storyBoard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        chatViewController.loadViewIfNeeded()
    }

    override func tearDown() {
       super.tearDown()
    }

    func testInitialisation() {
        XCTAssertNotNil(chatViewController.customNavigationBar)
    }
    
    func testSetupMessageCollectionView() {
        var chatDetailsViewModel = ChatDetailsViewModel()
        let chatHistoryList = try? chatDetailsViewModel.getChatDetails(id: 9)
        chatViewController.chatVM?.chathistory = chatHistoryList
        chatViewController.setupMessageCollectionView()
        XCTAssertNotNil(chatViewController.chatVM)
    }
}
