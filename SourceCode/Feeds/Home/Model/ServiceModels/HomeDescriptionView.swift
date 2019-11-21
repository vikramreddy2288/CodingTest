//
//  HomeDescriptionView.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit

struct HomeDescriptionView: Codable {
    let title: HomeTextView
    let description: HomeTextView
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
    }
    
     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(HomeTextView.self, forKey: .title)
        description = try container.decode(HomeTextView.self, forKey: .description)
    }
}

extension HomeDescriptionView {
    // This func is used to get Attributed string for title, based on the values for that module
    func getTitleText(completionBlock: @escaping (NSAttributedString) -> Void) {
        title.getTitleValue { (attributedText) in
            completionBlock(attributedText)
        }
    }
    
    // This func is used to get Attributed string for description, based on the values for that module
    func getDescriptionText(completionBlock: @escaping (NSAttributedString) -> Void) {
        description.getTitleValue(isBold: false) { (attributedText) in
            completionBlock(attributedText)
        }
    }
}
