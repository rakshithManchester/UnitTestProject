//
//  DataViewModel.swift
//  MVVMSample
//
//  Created by Antonio Corrales on 26/6/18.
//  Copyright © 2018 DesarrolloManzana. All rights reserved.
//

import UIKit
import InputBarAccessoryView
import SwiftUI

class ChatViewModel: ObservableObject {

    var chathistory: [ChatHistory]?

    init(chathistory: [ChatHistory]? = nil) {
        self.chathistory = chathistory
    }

    var datas: [Chats] = [Chats]()
    var reloadTableView: (() -> Void)?
    var showError: (() -> Void)?
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    @Published var chatlist: [Chats] = []

    func getChats(filename: String = "myJsonFile0") throws -> [Chats] {
        if let jsonfileurl = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: jsonfileurl)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ConversationDetails.self, from: data)
                guard !jsonData.chats.isEmpty else {
                    return []
                }
                self.chatlist = jsonData.chats
            } catch {
                throw error.self
            }
        }
        return self.chatlist
    }
}
