//
//  ServiceDataModel.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation

/// This Model Contains information of both request and response
class ServiceDataModel: NSObject {
    private(set) var request: ServiceRequest
    var response: ServiceResponse

    init(request: ServiceRequest, response: ServiceResponse? = nil) {
        self.request = request
        if let response = response {
            self.response = response
        } else {
            self.response = ServiceResponse()
        }
    }
}
