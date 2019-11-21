//
//  HomeModel.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Home
struct Home: Codable {
    let page: Page
}

// MARK: - Page
struct Page: Codable {
    let cards: [HomeViewElement]
}

// MARK: - Attributes
struct Attributes: Codable {
    let textColor: String
    let font: Font

    enum CodingKeys: String, CodingKey {
        case textColor = "text_color"
        case font
    }
}

extension Attributes {
    // used to get text color from hex value
    func getTextColor() -> UIColor {
        return HexToRGBHandler().hexStringToUIColor(hex: textColor) ?? UIColor.white
    }
}

// MARK: - Font
struct Font: Codable {
    let size: Int
}

extension Font {
    // used to get bold font which is used for title
    func getBoldFont() -> UIFont? {
        return UIFont.boldSystemFont(ofSize: CGFloat(size))
    }
    
    // used to get font which is used in displaying description
    func getFont() -> UIFont? {
        return UIFont.systemFont(ofSize: CGFloat(size))
    }
}
