//
//  TextDescriptionCell.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation
import UIKit

class TextDescriptionCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    /// Clean up the view elements in the table before they were reused
    override func prepareForReuse() {
        titleLabel.attributedText = nil
        descriptionLabel.attributedText = nil
    }
    
    /// Used to configure the view
    /// - Parameter option: receives table options as input which has all the information required for that view
    override func configureUI(option: TableOption) {
        tableOption = option
        titleLabel.attributedText = option.title
        descriptionLabel.attributedText = option.description
        layoutIfNeeded()
    }
}
