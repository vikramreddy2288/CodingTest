//
//  Constants.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation
import UIKit

/// End Point Uril, this struct will have information about the domain and path of the url
struct FeedsEndPoints {
    static let domain = "https://private-8ce77c-tmobiletest.apiary-mock.com"
    static let path = "/test/home"
    
    static var apiEndPoint: String {
        return domain + path
    }
}
