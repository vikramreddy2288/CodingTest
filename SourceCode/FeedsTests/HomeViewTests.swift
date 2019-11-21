//
//  HomeViewTests.swift
//  FeedsTests
//
//  Created by vragireddy on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import XCTest
@testable import Feeds

class HomeViewTests: XCTestCase {
    
    var tableViewController: HomeTableViewController = HomeTableViewController()
    var loadingViewController: HomeLoadingViewController = HomeLoadingViewController()
    
    override func setUp() {
        super.setUp()
        setUpLoadingViewController()
        setUpTableViewController()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadingViewController() {
        XCTAssertNotNil(loadingViewController, "View controller is nil")
        XCTAssertNotNil(loadingViewController.backgroundView, "background view is nil")
        XCTAssertNotNil(loadingViewController.loadingLabel, "label is nil")
        XCTAssertNotNil(loadingViewController.refreshButton, "refresh button is nil")
        XCTAssertNotNil(loadingViewController.shimmerView, "shimmer is nil")
        
        loadingViewController.startShimmering(title: "title")
        XCTAssertEqual(loadingViewController.loadingLabel.text, "title")
        XCTAssertEqual(loadingViewController.refreshButton.isHidden, true)
        
        loadingViewController.stopShimmering()
        XCTAssertEqual(loadingViewController.shimmerView.isHidden, true)
        
        loadingViewController.showErrorMessage("Error")
        XCTAssertEqual(loadingViewController.loadingLabel.text, "Error")
    }
    
    func testViewController() {
        XCTAssertNotNil(tableViewController, "View controller is nil")
        XCTAssertNotNil(tableViewController.homeFeedsTableView, "table view is nil")
        let textViewCell = tableViewController.homeFeedsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextViewCell
        XCTAssertNotNil(textViewCell, "table view cell is nil")
        XCTAssertEqual(textViewCell?.titleLabel.attributedText?.string, "Hello, Welcome to App!")
        
        let descViewCell = tableViewController.homeFeedsTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TextDescriptionCell
        XCTAssertNotNil(descViewCell, "table view cell is nil")
        XCTAssertEqual(descViewCell?.titleLabel.attributedText?.string, "Check out our App every week for exciting offers.")
        XCTAssertEqual(descViewCell?.descriptionLabel.attributedText?.string, "Offers available every week!")
        
        let imageViewCell = tableViewController.homeFeedsTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? ImageDescriptionCell
        XCTAssertNotNil(imageViewCell, "table view cell is nil")
        XCTAssertEqual(imageViewCell?.titleLabel.attributedText?.string, "Movie ticket to Dark Phoenix!")
        XCTAssertEqual(imageViewCell?.descriptionLabel.attributedText?.string, "Tap to see offer dates and rescriptions.")
    }
    
    func setUpTableViewController() {
        guard let data = TestUtils().loadData("HomeFeeds") else {
            return
        }
        
        let viewModel = HomeViewModel.sharedInstance
        viewModel.getHomeData(data: data) { (home) in
            viewModel.getHomeCards(data: home!) { (options) in
                viewModel.data = options
                guard let viewController =  UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeTableViewController.self)) as? HomeTableViewController else {
                    return XCTFail("Could not instantiate Settings from Settings storyboard")
                }
                self.tableViewController = viewController
                let _ = self.tableViewController.view
                self.tableViewController.reloadTableView()
            }
        }
    }
    
    func setUpLoadingViewController() {
        guard let viewController =  UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeLoadingViewController.self)) as? HomeLoadingViewController else {
            return XCTFail("Could not instantiate Settings from Settings storyboard")
        }
        self.loadingViewController = viewController
        let _ = self.loadingViewController.view
    }
    
}
