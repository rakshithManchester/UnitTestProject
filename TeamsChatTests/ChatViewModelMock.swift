//
//  ChatViewModelMock.swift
//  TeamsChatTests
//
//  Created by Appaiah on 08/07/23.
//

import XCTest
@testable import TeamsChat

final class ChatViewModelMock: XCTestCase {
    var chatList: [Chats]!
    var chat: Chats!
    override func setUp() {
        super.setUp()
        chat = Chats(id: "1", name: "chatName", picture: "chatPicture", latest_timestamp: "chatTimestamp", lastChat: "chatLastCha", chat_history: [])
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func getEmptyChatList() -> [Chats] {
        return [Chats]()
    }
        
    func getChatListNonEmpty() -> [Chats] {
        let chatList: [Chats] = [chat]
        return chatList
    }
    
}
