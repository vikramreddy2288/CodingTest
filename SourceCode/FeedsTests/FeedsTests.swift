//
//  FeedsTests.swift
//  FeedsTests
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import XCTest
@testable import Feeds

class FeedsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeFeeds() {
        guard let response = TestUtils().loadJSON("HomeFeeds") as? [String: Any] else {
            XCTFail("Invalid Response")
            return
        }
        XCTAssertNotNil(response)
        
        guard let data = TestUtils().loadData("HomeFeeds") else {
            XCTFail("Invalid Data")
            return
        }
        XCTAssertNotNil(data)
        
        let viewModel = HomeViewModel.sharedInstance
        XCTAssertNotNil(viewModel)
        
        var homeData: Home?
        viewModel.getHomeData(data: data) { (home) in
            XCTAssertNotNil(home, "Home Service Model is empty")
            homeData = home!
        }
        
        viewModel.getHomeCards(data: homeData!) { (options) in
            XCTAssertNotNil(options, "table options array is empty")
            viewModel.data = options
        }
        
        let noOfRows = viewModel.getNoOfRows()
        XCTAssertEqual(noOfRows, 6)
        
        XCTAssertNotNil(homeData?.page, "Page information in home module is nil")
        XCTAssertNotNil(homeData?.page.cards, "Cards array in page is nil")
        XCTAssertEqual(homeData?.page.cards.count, 6)
        XCTAssertEqual(homeData?.page.cards.count, noOfRows)
        
        let textServiceModel = homeData?.page.cards[0]
        XCTAssertNotNil(textServiceModel, "text service model is empty")
        
        let textOption = viewModel.getViewModel(row: 0)
        XCTAssertNotNil(textOption, "text view model is empty")
        let title = textOption.title.string
        XCTAssertNotNil(title, "text view model title is empty")
        XCTAssertEqual(title, "Hello, Welcome to App!")
        
        let descServiceModel = homeData?.page.cards[1]
        XCTAssertNotNil(descServiceModel, "description service model is empty")
        
        let descOption = viewModel.getViewModel(row: 1)
        XCTAssertNotNil(descOption, "description view model is empty")
        let title1 = descOption.title.string
        XCTAssertNotNil(title1, "title is empty")
        XCTAssertEqual(title1, "Check out our App every week for exciting offers.")
        let desc = descOption.description?.string
        XCTAssertNotNil(desc, "description is empty")
        XCTAssertEqual(desc, "Offers available every week!")
        
        let imageModel = homeData?.page.cards[2]
        XCTAssertNotNil(imageModel, "image service model is empty")
        
        let imageOption = viewModel.getViewModel(row: 2)
        XCTAssertNotNil(imageOption, "image view model is empty")
        let title2 = imageOption.title.string
        XCTAssertNotNil(title2, "Title is empty")
        XCTAssertEqual(title2, "Movie ticket to Dark Phoenix!")
        let desc2 = imageOption.description?.string
        XCTAssertNotNil(desc2, "description is empty")
        XCTAssertEqual(desc2, "Tap to see offer dates and rescriptions.")
        let image = imageOption.image
        XCTAssertNotNil(image, "image url is empty")
        XCTAssertEqual(image, "https://qaevolution.blob.core.windows.net/assets/ios/3x/Featured@4.76x.png")
    }
    
    func testTableOptions() {
        
        let textOption = TableOption(title: NSAttributedString(string: "title"), cellId: .textViewCell)
        XCTAssertNotNil(textOption, "text view model is nil")
        XCTAssertEqual(textOption.title.string, "title")
        XCTAssertEqual(textOption.cellId, .textViewCell)
        
        let descOption = TableOption(title: NSAttributedString(string: "title"),
                                     description: NSAttributedString(string: "desc"),
                                     cellId: .textDescriptionCell)
        XCTAssertNotNil(descOption, "text view model is nil")
        XCTAssertEqual(descOption.title.string, "title")
        XCTAssertEqual(descOption.description?.string, "desc")
        XCTAssertEqual(descOption.cellId, .textDescriptionCell)
        
        let imageOption = TableOption(title: NSAttributedString(string: "title"),
                                      description: NSAttributedString(string: "desc"),
                                      image: "image.path",
                                      imageHeight: 50,
                                      cellId: .imageDescriptionCell)
        XCTAssertNotNil(imageOption, "text view model is nil")
        XCTAssertEqual(imageOption.title.string, "title")
        XCTAssertEqual(imageOption.description?.string, "desc")
        XCTAssertEqual(imageOption.image, "image.path")
        XCTAssertEqual(imageOption.imageHeight, 50)
        XCTAssertEqual(imageOption.cellId, .imageDescriptionCell)
        
    }
    
}
