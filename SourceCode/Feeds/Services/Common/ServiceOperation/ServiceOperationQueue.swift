//
//  ServiceOperationQueue.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation
final class ServiceOperationQueue: OperationQueue {

    static let sharedOperation = ServiceOperationQueue()
    private struct Constants {
        static let kMaxConcurrentOperationCount = 10
        static let kQueueName = "GlobalOperationQueue"
    }

    private override init() {
        super.init()
        maxConcurrentOperationCount = Constants.kMaxConcurrentOperationCount
        name = Constants.kQueueName
    }
}
