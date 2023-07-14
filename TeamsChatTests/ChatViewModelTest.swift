//
//  MockChatViewModel.swift
//  TeamsChatTests
//
//  Created by Appaiah on 05/07/23.
//

import XCTest
@testable import TeamsChat

final class ChatViewModelTest: XCTestCase {
    
    var chatViewModel: ChatViewModel!
    var chatHistory: ChatHistory!
    var chatHistorys: [ChatHistory]?
    
    override func setUp() {
         super.setUp()
        let sender = Sender(photoURL: "",
                            senderId: "2",
                            displayName: "Ronak Sankhala")
        chatHistory = ChatHistory(sender: sender, messageId: "100", sentDate: "100", kind: "unknown")
        chatHistorys = [chatHistory]
        chatViewModel = ChatViewModel(chathistory: chatHistorys)
    }

    override func tearDown()  {
         super.tearDown()
        chatHistorys = nil
    }
    
    func testInitialisation() {
        XCTAssertEqual(chatViewModel.chathistory?.count, 1)
    }
    
    func testGetChats_Success() {
        do {
           let value = try? chatViewModel.getChats(filename: "myJsonFile0")
            XCTAssertEqual(value?.count, 10)
        } catch(let exp) {
            print(exp)
        }
        
    }
    
    func testGetChats_Failure() {
        do {
           let value = try? chatViewModel.getChats(filename: "MockMyJsonFile0")
            XCTAssertNil(value)
        } catch(let exp) {
            print(exp)
        }
        
    }
}
