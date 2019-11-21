//
//  ServiceRequest.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation

enum RequestMethodType: String {
    case get, post, put, delete
    func uppercased() -> String {
        return self.rawValue.uppercased()
    }
}

enum RequestContentType: String {
    case URLEncoded, JSON, none
}

class ServiceRequest: NSObject {

    private(set) var apiEndPoint: String
    private(set) var httpMethod: RequestMethodType
    private(set) var contentType: RequestContentType
    private(set) var requestParams: Any?
    private(set) var additionalHeaders: [String: String]?

    init(apiEndPoint: String,
         httpMethod: RequestMethodType,
         contentType: RequestContentType,
         requestParams: Any? = nil,
         additionalHeaders: [String: String]? = nil) {
        self.apiEndPoint = apiEndPoint
        self.httpMethod = httpMethod
        self.contentType = contentType
        self.requestParams = requestParams
        self.additionalHeaders = additionalHeaders
    }
}
