//
//  HomeViewElements.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit

enum HomeViewTypes: String {
    case text = "text"
    case description = "title_description"
    case image = "image_title_description"
}

// MARK: - view element
enum HomeViewElement {
    case text(HomeTextView)
    case titleDescription(HomeDescriptionView)
    case imageDescription(HomeImageView)
    case unknown
}

extension HomeViewElement: Codable {
    private enum CodingKeys: String, CodingKey {
        case cardType = "card_type"
        case card = "card"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .cardType)
        
        switch type {
        case HomeViewTypes.text.rawValue:
            let payload = try container.decode(HomeTextView.self, forKey: .card)
            self = .text(payload)
        case HomeViewTypes.description.rawValue:
            let payload = try container.decode(HomeDescriptionView.self, forKey: .card)
            self = .titleDescription(payload)
        case HomeViewTypes.image.rawValue:
            let payload = try container.decode(HomeImageView.self, forKey: .card)
            self = .imageDescription(payload)
        default:
            self = .unknown
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .text(let card):
            try container.encode(HomeViewTypes.text.rawValue, forKey: .cardType)
            try container.encode(card, forKey: .card)
        case .titleDescription(let card):
            try container.encode(HomeViewTypes.description.rawValue, forKey: .cardType)
            try container.encode(card, forKey: .card)
        case .imageDescription(let card):
            try container.encode(HomeViewTypes.image.rawValue, forKey: .cardType)
            try container.encode(card, forKey: .card)
        case .unknown:
            let context = EncodingError.Context(codingPath: [], debugDescription: "Invalid Data")
            throw EncodingError.invalidValue(self, context)
        }
    }
}
