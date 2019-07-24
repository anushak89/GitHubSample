//
//  CommitCell.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/24/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import UIKit

class CommitCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var hashLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
