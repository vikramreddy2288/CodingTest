//
//  HomeImageView.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit

// MARK: - Size
struct Size: Codable {
    let width, height: Int
}

// MARK: - Image
struct Image: Codable {
    let url: String
    let size: Size
}

extension Image {
    func getImageUrl() -> String {
        return url
    }
    
    // Used to caliculate the height of the image
    func getImageHeight() -> Int {
        return (size.height * Int(UIScreen.main.bounds.width)) / size.width
    }
}

struct HomeImageView: Codable {
    let title: HomeTextView?
    let description: HomeTextView?
    let image: Image?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case image = "image"
    }
    
     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(HomeTextView.self, forKey: .title)
        description = try container.decode(HomeTextView.self, forKey: .description)
        image = try container.decode(Image.self, forKey: .image)
    }
}

extension HomeImageView {
    // This func is used to get Attributed string for title, based on the values for that module
    func getTitleText(completionBlock: @escaping (NSAttributedString) -> Void) {
        guard let title = title else {
            completionBlock(NSAttributedString())
            return
        }
        title.getTitleValue { (attributedText) in
            completionBlock(attributedText)
        }
    }
    
    // This func is used to get Attributed string for description, based on the values for that module
    func getDescriptionText(completionBlock: @escaping (NSAttributedString) -> Void) {
        guard let description = description else {
            completionBlock(NSAttributedString())
            return
        }
        description.getTitleValue(isBold: false) { (attributedText) in
            completionBlock(attributedText)
        }
    }
    
    // This func is used to get path of the image url and height of the image, based on the values for that module
    func getImageDetails() -> (url: String?, height: Int) {
        guard let image = image else {
            return (nil,0)
        }
        return (image.getImageUrl(), image.getImageHeight())
    }
}
