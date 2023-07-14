//
//  ReusableConversationTableViewCell.swift
//  TeamsChat
//
//  Created by Ronak Sankhala on 09/12/22.
//

import UIKit

class ReusableConversationTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLastMessage: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgUserProfile?.image = UIImage(named: "user_profile")
        imgUserProfile.backgroundColor = .clear
        imgUserProfile.layer.cornerRadius = imgUserProfile.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
