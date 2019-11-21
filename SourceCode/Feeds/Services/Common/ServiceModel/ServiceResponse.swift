//
//  ServiceResponse.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation

class ServiceResponse: NSObject {

    var responseData: Data?
    var timeTaken: Double?
    var error: Error?
    var isResponseFailed: Bool = false
    var statusCode: Int = 0

    var responseJsonData: Any? {
        if let responseData = responseData {
            do {
                let value = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                return value
            } catch {
                tLog("Serialization failure - input: \(String(describing: responseStringData)) ")
            }
        }
        return nil
    }

    var responseStringData: String? {
        if let responseData = responseData {
            let value = String(data: responseData, encoding: .utf8)
            return value
        }
        return nil
    }
}
