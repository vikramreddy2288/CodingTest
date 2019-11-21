//
//  HomeViewModel.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit

protocol HomeViewModelDataSource {
    func getHomeFeeds(completion: @escaping ([TableOption]) -> Void)
    func getHomeData(data: Data, completion: @escaping (Home?) -> Void)
    func getHomeCards(data: Home, completion: @escaping ([TableOption]) -> Void)
}

protocol HomeViewModelDelegate {
    func reloadView(tableOptions: [TableOption])
}

class HomeViewModel: NSObject {

    static let sharedInstance = HomeViewModel()
    var delegate: HomeViewModelDelegate?
    var data: [TableOption] = []
    
    private override init() {
        super.init()
    }
    
    // Used to get the no of rows required for the table
    func getNoOfRows() -> Int {
        return data.count
    }
    
    // used to get particular view model that is required for the row
    func getViewModel( row: Int) -> TableOption {
        return data[row]
    }
}

extension HomeViewModel: HomeViewModelDataSource {
    
    /// This function is used to configure data for view model and also notifies view controller using delegate
    func configureData() {
        getHomeFeeds { [weak self] (options) in
            guard let self = self else {
                return
            }
            self.data = options
            self.delegate?.reloadView(tableOptions: options)
        }
    }
    
    /// This Func is used to make the Api call and retun the view models
    /// - Parameter completion: the completion block return array of view models that are required for constructing the table
    func getHomeFeeds(completion: @escaping ([TableOption]) -> Void) {
        let options = [TableOption]()
        
        HomeDataManager().getFeeds(url: FeedsEndPoints.apiEndPoint) { [weak self] (data) in
            
            guard let self = self else {
                return
            }
            guard let data = data else {
                completion(options)
                return
            }
            
            self.getHomeData(data: data) { [weak self] (homeData) in
                guard let self = self else {
                    return
                }
                
                guard let homeData = homeData else {
                    completion(options)
                    return
                }
                
                self.getHomeCards(data: homeData) { (tableOptions) in
                    self.data = tableOptions
                    completion(tableOptions)
                }
            }
        }
    }
    
    /// This function is used to convert the api response data in to service models using codables
    /// - Parameters:
    ///   - data: api response data from server
    ///   - completion: retruns service modle Home Object
    func getHomeData(data: Data, completion: @escaping (Home?) -> Void) {
        do {
            let decoder = JSONDecoder()
            let homeData = try decoder.decode(Home.self, from: data)
            completion(homeData)
        } catch let catchError {
            tLog("****** Home Data Model Error Begin ******")
            tLog(catchError)
            tLog(catchError.localizedDescription)
            tLog("****** Home Data Model Error End ******")
            completion(nil)
            return
        }
    }
        
    /// This func is used to convert the service models in to corresponding view models
    /// - Parameters:
    ///   - data: is Service Model Object Home
    ///   - completion: return array of  view models that are required for constructing the table
    func getHomeCards(data: Home, completion: @escaping ([TableOption]) -> Void) {
        var options = [TableOption]()
        let cards = data.page.cards
        
        for card in cards {
            switch card {
            case .text(let text):
                text.getTitleValue { (title) in
                    let textOption = TableOption(title: title, cellId: .textViewCell)
                    options.append(textOption)
                }
            case .titleDescription(let titleDescView):
                titleDescView.getTitleText { (title) in
                    titleDescView.getDescriptionText { (description) in
                        let descriptionOption = TableOption(title: title,
                                                            description: description,
                                                            cellId: .textDescriptionCell)
                        options.append(descriptionOption)
                    }
                }
            case .imageDescription(let imageDescView):
                imageDescView.getTitleText { (title) in
                    imageDescView.getDescriptionText { (description) in
                        let imageDetails = imageDescView.getImageDetails()
                        
                        let imageOption = TableOption(title: title,
                                                      description: description,
                                                      image: imageDetails.url ?? "",
                                                      imageHeight: imageDetails.height,
                                                      cellId: .imageDescriptionCell)
                        options.append(imageOption)
                    }
                }
            case .unknown:
                let option = TableOption(title: NSAttributedString(), cellId: .textViewCell)
                options.append(option)
            }
        }
        completion(options)
    }
}
