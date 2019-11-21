//
//  HomeDataManager.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit

/// call back after retriving the response, retuns cards model
typealias ServiceResponseCompletion = (ServiceDataModel?) -> Void

class HomeDataManager: NSObject {
    /// This method is used to get cards from home url,
    ///
    /// - Parameters:
    ///   - url: final url path
    ///   - completionBlock: retuns cards after succesful the service call
    func getFeedsResponse(url: String, completionBlock: @escaping ServiceResponseCompletion) {
        guard let request = getFeedsRequest(url: url) else {
            tLog("Unable to form request")
            return
        }
        let model = ServiceDataModel(request: request)
        let serviceOperation = ServiceOperation.serviceOperation(dataModel: model) {(serviceModel) in
            completionBlock(model)
        }
        
        if let serviceOperation = serviceOperation {
            ServiceOperationQueue.sharedOperation.addOperation(serviceOperation)
        } else {
            tLog("Unable to create service operation")
        }
    }
    
    //This method is used to get url request for the endpoint url
    func getFeedsRequest(url: String) -> ServiceRequest? {
        let request = ServiceRequest(apiEndPoint: url, httpMethod: .get, contentType: RequestContentType.JSON)
        return request
    }
    
    func getFeeds(url: String, completionBlock: @escaping (Data?) -> Void) {
        getFeedsResponse(url: url) { (dataModel) in
            if let response = dataModel?.response.responseData,
                let responseString = dataModel?.response.responseStringData {
                HomeDataStorage().writeDataToFile(data: responseString)
                completionBlock(response)
            } else {
                let previousData = HomeDataStorage().getHomeFeedsFromDisk()
                completionBlock(previousData)
            }
        }
    }
    
}
