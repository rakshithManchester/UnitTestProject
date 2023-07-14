//
//  ViewController.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 07/12/22.
//

import UIKit

class ConversationsViewController: UIViewController {

    var chatVM: ChatViewModel?
    @IBOutlet weak var tblConversation: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        chatVM = ChatViewModel(chathistory: nil)
        setupUI()
        initViewModel()
        customNavigationBar.titleLabel.text = NSLocalizedString("Chat Title", comment: "Localizable")
        setupTableView()
    }

    func setupUI() {
        searchBar.backgroundImage = UIImage()
        customNavigationBar.leftButton.addTarget(self, action: #selector(avtarButtonTapped(_:)), for: .touchUpInside)
    }

    @objc func avtarButtonTapped(_ sender: UIButton) {

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    private func setupTableView() {
        tblConversation.dataSource = self
        tblConversation.delegate = self
        let conversationTableViewcell = UINib(nibName: "ReusableConversationTableViewCell",
                                              bundle: nil)
        self.tblConversation.register(conversationTableViewcell,
                                      forCellReuseIdentifier: "ReusableConversationTableViewCell")
        let recentUserChatTableViewcell = UINib(nibName: "RecentChatTableViewCell",
                                              bundle: nil)
        self.tblConversation.register(recentUserChatTableViewcell,
                                      forCellReuseIdentifier: "RecentChatTableViewCell")
        tblConversation.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        if !isLoggedIn { }
    }

    func initViewModel() {
        chatVM?.reloadTableView = {
            DispatchQueue.main.async { /*self.tableView.reloadData()*/ }
        }
        chatVM?.showError = {
            DispatchQueue.main.async { self.showAlert(NSLocalizedString("Alert Message", comment: "Localizable")) }
        }
        chatVM?.showLoading = {
            DispatchQueue.main.async { /*self.activityIndicator.startAnimating()*/ }
        }
        chatVM?.hideLoading = {
            DispatchQueue.main.async { /*self.activityIndicator.stopAnimating()*/ }
        }
        try? chatVM?.getChats()
    }
}

extension ConversationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 65
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            guard let count = self.chatVM?.chatlist.count else {
                return 0
            }
            return count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let conversationCell = tblConversation.dequeueReusableCell(withIdentifier: "RecentChatTableViewCell") as? RecentChatTableViewCell else {
                return UITableViewCell()
            }
            return conversationCell
        } else {
            guard let conversationCell = tblConversation.dequeueReusableCell(withIdentifier: "ReusableConversationTableViewCell") as? ReusableConversationTableViewCell else {
                return UITableViewCell()
            }
            let item = self.chatVM?.chatlist[indexPath.row]
            conversationCell.lblUserName.text = item?.name
            conversationCell.lblLastMessage.text = item?.lastChat
            conversationCell.lblDateTime.text = item?.latest_timestamp
            return conversationCell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ChatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        let item = self.chatVM?.chatlist[indexPath.row]
        ChatVC?.title = item?.name
        ChatVC?.chatid = indexPath.row
        ChatVC?.chathistory = item?.chat_history
        navigationController?.pushViewController(ChatVC!, animated: true)
    }
}
