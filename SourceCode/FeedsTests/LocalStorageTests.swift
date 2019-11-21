//
//  LocalStorageTests.swift
//  FeedsTests
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import XCTest
@testable import Feeds

class LocalStorageTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalStorage() {
        guard let data = TestUtils().loadData("HomeFeeds") else {
            XCTFail("Invalid Data")
            return
        }
        XCTAssertNotNil(data)
        
        let string = String(data: data, encoding: .utf8)
        XCTAssertNotNil(string)
        
        HomeDataStorage().writeDataToFile(data: string!)
        let data2 = HomeDataStorage().getHomeFeedsFromDisk()
        XCTAssertNotNil(data2)
        let string2 = String(data: data2!, encoding: .utf8)
        XCTAssertEqual(string, string2, "String saved and retrevied from the disk are same")
    }

    func testRechability() {
        let connection = Reachability()?.connection
        XCTAssertNotNil(connection)
    }
}
