//
//  MockChatDetailsViewModel.swift
//  TeamsChatTests
//
//  Created by Appaiah on 05/07/23.
//

import XCTest
@testable import TeamsChat

final class ChatDetailsViewModelTest: XCTestCase {
    var chatDetailsViewModel: ChatDetailsViewModel!
    var chatHistorys: [ChatHistory]?
    
    override func setUp() {
        super.setUp()
        chatDetailsViewModel = ChatDetailsViewModel()
    }
    
    override func tearDown() {
        chatDetailsViewModel = nil
        chatHistorys = nil
        super.tearDown()
    }
    
    func testGetChatDetails_Failure() {
        guard let chatHistorys = try? chatDetailsViewModel.getChatDetails(id: 11) else {
            XCTAssertNil(chatHistorys)
            return
        }
    }
    
    func testGetChatDetails_Success() {
        if let jsonfileurl = Bundle.main.url(forResource: "MockMyJsonFile0", withExtension: "json") {
            do {
                guard let data = try? Data(contentsOf: jsonfileurl) else { return }
                let decoder = JSONDecoder()
                let jsonData = try? decoder.decode(ConversationDetails.self, from: data)
                guard let chatHistorys = try? chatDetailsViewModel.getChatDetails(id: 1) else { return }
                XCTAssertNotNil(chatHistorys.count)
            }
        }
    }
}
