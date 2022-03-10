//
//  MessageTableViewCell.swift
//  MyChatApp
//
//  Created by nayan.khadase on 09/11/21.
//  Copyright © 2021 nayan.khadase. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var imgLabel: UIImageView!
    @IBOutlet weak var youImage: UIImageView!
    @IBOutlet weak var msgBubble: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        msgBubble.layer.cornerRadius = msgLabel.frame.height / 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
