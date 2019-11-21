//
//  HomeTextView.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation
import UIKit

struct HomeTextView: Codable {
    let value: String
    let attributes: Attributes
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
        case attributes = "attributes"
    }
}

extension HomeTextView {
    
    // This func is used to get Attributed string based on the values for that module
    func getTitleValue(isBold: Bool = true, completionBlock: @escaping (NSAttributedString) -> Void) {
        
        var attributedString = NSAttributedString(string: self.value)
        
        if let font = isBold ? self.attributes.font.getBoldFont() : self.attributes.font.getFont() {
            let fontAttribute = [ NSAttributedString.Key.font: font ]
            attributedString = attributedString.addAttributes(attributes: fontAttribute)
        }
        
        let color = self.attributes.getTextColor()
        let textColorAttribute = [NSAttributedString.Key.foregroundColor : color]
        attributedString = attributedString.addAttributes(attributes: textColorAttribute)
        
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        let styleAttribute = [NSAttributedString.Key.paragraphStyle: style]
        attributedString = attributedString.addAttributes(attributes: styleAttribute)
        
        completionBlock(attributedString)
    }
}
