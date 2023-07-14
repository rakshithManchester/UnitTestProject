//
//  ChatViewController.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 09/12/22.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {

    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    private var messages = [Message]()
    private let selfSender = Sender(photoURL: "",
                                    senderId: "1",
                                    displayName: "Hardik Sankhala")
    private let secondSender = Sender(photoURL: "",
                                      senderId: "2",
                                      displayName: "Ronak Sankhala")
    struct Constants {
        static let attachMedia = NSLocalizedString("Sheet Title", comment: "Localizable")
        static let sheetMessage = NSLocalizedString("Sheet Message", comment: "Localizable")
        static let attachPhoto = NSLocalizedString("Attach Photo", comment: "Localizable")
        static let selectPhotoMessage = NSLocalizedString("Photo Message", comment: "Localizable")
        static let photo = NSLocalizedString("Photo", comment: "Localizable")
        static let video = NSLocalizedString("Video", comment: "Localizable")
        static let audio = NSLocalizedString("Audio", comment: "Localizable")
        static let camera = NSLocalizedString("Camera", comment: "Localizable")
        static let photoGallery = NSLocalizedString("Photo Library", comment: "Localizable")
        static let cameraAlertMessage = NSLocalizedString("Camera Alert Message", comment: "Localizable")
        static let alert = NSLocalizedString("Alert", comment: "Localizable")
        static let okay = NSLocalizedString("Ok", comment: "Localizable")
    }

    var chatid: Int = 0
    var chatVM: ChatViewModel?

    var chathistory: [ChatHistory]?
    let dateformatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        chatVM = ChatViewModel(chathistory: chathistory)

        setupNavigationBar()
        setupInputButton()
        setupMessageCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func setupInputButton() {
        let button = InputBarButtonItem()
        button.setSize(CGSize(width: 35, height: 35), animated: false)
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        button.onTouchUpInside { [weak self] _ in
            self?.presentInputActionSheet()
        }

        messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
        messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
    }

    private func presentAudioInputActionSheet() {
    }

    private func setupNavigationBar() {
        customNavigationBar.title = "Ronak Sankhala"
        customNavigationBar.userStatus.isHidden = false
        customNavigationBar.userStatus.text = "Last Seen 12:30 PM"
        customNavigationBar.backButtonWidthConstraint.constant = 30
        customNavigationBar.backButtonTapped = { [weak self] in

            guard let strongSelf = self else {
                return
            }
            strongSelf.navigationController?.popViewController(animated: true)
        }
    }

    func setupMessageCollectionView() {
        guard let history = chatVM?.chathistory else {
            return
        }

        for msg in history {
            messages.append(Message(sender: msg.sender,
                                    messageId: msg.messageId,
                                    sentDate: dateformatter.date(from: msg.sentDate) ?? Date(),
                                    kind: .text(msg.kind)))
        }
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        self.view.backgroundColor = .red
        messageInputBar.delegate = self
        if !messages.isEmpty {
            DispatchQueue.main.async {
                self.messagesCollectionView.reloadDataAndKeepOffset()
                self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
            }
        }
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else { return }

        let message = Message(sender: selfSender,
                              messageId: "1",
                              sentDate: Date(),
                              kind: .text(text))
        messages.append(message)
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadDataAndKeepOffset()
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
            self.messageInputBar.inputTextView.resignFirstResponder()
        }
    }
}

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> MessageKit.SenderType {
        return selfSender
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }

    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let sender = message.sender

        if sender.senderId == selfSender.senderId {
            // set imgae for Self Sender
            avatarView.image = UIImage(named: "user_profile")
        } else {
            // Set Image for Other User
            avatarView.image = UIImage(named: "otherUser_Profile")
        }
    }
}

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let placeHolder = UIImage(systemName: "person.circle.fill") else { return }
        let media = Media(image: image, placeholderImage: placeHolder, size: CGSize(width: 100, height: 100))
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind: .photo(media)))
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadDataAndKeepOffset()
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        }
    }
}

// MARK: Setup UI Dynamic UI Alert Controller
extension ChatViewController {
    private func presentInputActionSheet() {
        guard let actionSheet = Constant.Alert(alertFor: .Media, title: Constants.attachMedia, message: Constants.sheetMessage, cancelButton: true, buttonArray: [Constants.photo, Constants.video, Constants.audio], style: .actionSheet, completionMedia: { [weak self] mediaType in
            switch mediaType {
            case .Photo:
                // Two Option for Selecting or Capturing Photo using Camera and Photo Gallery
                self?.presentPhotoInputActionSheet()
            case .Video:
                // Video Option is not available, in Feature we can add it.
                self?.presentVideoInputActionSheet()
            case .Audio:
                break
            }
        }) else { return }
        present(actionSheet, animated: true)
    }

    private func presentPhotoInputActionSheet() {
        guard let actionSheet = Constant.Alert(alertFor: .Source, title: Constants.attachPhoto, message: Constants.selectPhotoMessage, cancelButton: true, buttonArray: [Constants.camera, Constants.photoGallery], style: .actionSheet, completionMediaSelection: { [weak self] mediaType in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            switch mediaType {
            case .Camera:
                if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                    guard let alert = Constant.Alert(alertFor: .Other, title: Constants.alert, message: Constants.cameraAlertMessage, cancelButton: false, buttonArray: [Constants.okay]) else { return }
                    self?.present(alert, animated: true, completion: nil)
                } else {
                    picker.sourceType = .camera
                    self?.present(picker, animated: true )
                }

            case .PhotoLibrary:
                picker.sourceType = .photoLibrary
                self?.present(picker, animated: true )
            }
        }) else { return }

        present(actionSheet, animated: true)
    }

    private func presentVideoInputActionSheet() {
    }
}
