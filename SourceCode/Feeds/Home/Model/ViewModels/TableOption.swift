//
//  TableOption.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit

/// These enums are the identifiers for table cells
enum TableCellIdentifier: String {
    case textViewCell = "TextViewCell"
    case textDescriptionCell = "TextDescriptionCell"
    case imageDescriptionCell = "ImageDescriptionCell"
}

class TableOption {
    
    var cellId: TableCellIdentifier
    var title: NSAttributedString
    var description: NSAttributedString?
    var image: String?
    var imageHeight: Int?
    
    init(title: NSAttributedString, cellId: TableCellIdentifier) {
        self.title = title
        self.cellId = cellId
    }
    
   convenience init(title: NSAttributedString, description:NSAttributedString, cellId: TableCellIdentifier) {
        self.init(title: title, cellId: cellId)
        self.description = description
    }
    
    convenience init(title: NSAttributedString, description:NSAttributedString, image: String, imageHeight: Int, cellId: TableCellIdentifier) {
        self.init(title: title, description:description, cellId: cellId)
        self.image = image
        self.imageHeight = imageHeight
    }
}
