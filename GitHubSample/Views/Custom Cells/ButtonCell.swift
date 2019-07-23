//
//  ButtonCell.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/23/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import UIKit

protocol ButtonCellDeleagte: AnyObject {
    func didPressExploreButton(_ cell: ButtonCell)
}
class ButtonCell: UITableViewCell {

    weak var delegate: ButtonCellDeleagte?
    
    @IBAction func fetchCommits(_ sender: UIButton) {
        // Inform delegate
        delegate?.didPressExploreButton(self)
    }
}
