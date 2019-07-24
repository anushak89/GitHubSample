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
    
    var cellViewModel: CommitCellViewModel? {
        didSet {
            updateCellDisplay()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset Data
        authorLabel.text = ""
        hashLabel.text = ""
        messageLabel.text = ""
    }

    func updateCellDisplay() {
        // Update Data
        authorLabel.text = cellViewModel?.author
        hashLabel.text = cellViewModel?.hash
        messageLabel.text = cellViewModel?.message
    }

}
