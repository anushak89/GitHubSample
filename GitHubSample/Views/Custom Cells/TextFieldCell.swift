//
//  TextFieldCell.swift
//  GitHubSample
//
//  Created by Anusha Kottiyal on 7/23/19.
//  Copyright © 2019 NextDigit. All rights reserved.
//

import UIKit

protocol TextFieldCellDeleagte: AnyObject {
    func textFieldCell(_ cell: TextFieldCell, didEnterText text: String)
}

enum FieldType {
    case user
    case repo
}

class TextFieldCell: UITableViewCell {

    weak var delegate: TextFieldCellDeleagte?
    var fieldType: FieldType!
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        configureUI()
    }

    func configureUI() {
        textField.placeholderColor(color: UIColor.white)
    }
}

// MARK: - TextField Delegate Methods
extension TextFieldCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldCell(self, didEnterText: textField.text ?? "")
    }
}

extension UITextField {
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6),
            NSAttributedString.Key.font: self.font!
            ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
}
