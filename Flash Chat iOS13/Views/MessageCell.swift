//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Shreyash Pattewar on 27/12/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height/5
        
        
    }
    
}
