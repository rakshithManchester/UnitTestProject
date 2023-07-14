//
//  ChatDetailsViewModel.swift
//  TeamsChat
//
//  Created by Capgemini on 14/12/22.
//

import Foundation
import SwiftUI

class ChatDetailsViewModel {
    @Published var chathistory: [ChatHistory] = [ChatHistory]()

    func getChatDetails(filename: String = "myJsonFile0", id: Int) throws -> [ChatHistory]? {
        if let jsonfileurl = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                guard let data = try? Data(contentsOf: jsonfileurl) else { return [] } // added
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ConversationDetails.self, from: data)
                guard id < jsonData.chats.count else {
                    return nil
                }
                guard !jsonData.chats[id].chat_history.isEmpty else {
                    return nil
                }
                chathistory = jsonData.chats[id].chat_history
            } catch {
                throw error
            }
        }
        return chathistory
    }
}
