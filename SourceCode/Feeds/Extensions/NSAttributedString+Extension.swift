//
//  NSAttributedString+Extension.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation
import UIKit

// This is extension on top of Attributed string to add attributes
extension NSAttributedString {
    
    func addAttributes(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let astr = self.mutableCopy() as! NSMutableAttributedString
        astr.addAttributes(attributes, range: NSRange(location: 0, length: length))
        return astr as NSAttributedString
    }
}
