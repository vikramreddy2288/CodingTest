//
//  TestUtils.swift
//  FeedsTests
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//
import UIKit
import XCTest

class TestUtils {
    // This method is used to get data from a json file
     func loadData(_ fileName: String) -> Data? {
        let errorMsg = "Bad or corrupt JSON for \(fileName).json"
        let bundle = Bundle(for: type(of: TestUtils()))
        guard let fileURL = bundle.url(forResource: fileName, withExtension: "json"),
            let data = NSData(contentsOf: fileURL) as Data? else {
                print(errorMsg)
                return nil
        }
        return data
    }
    
    // This method is used to get dictionary from a json file
    func loadJSON(_ fileName: String) -> [AnyHashable: Any] {
        let errorMsg = "Bad or failed JSON parsing for \(fileName).json"
        guard let data = TestUtils().loadData(fileName) else {
            return [:]
        }
        do {
            guard let data = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any] else {
                return [:]
            }
            return data
        } catch {
            XCTFail(errorMsg)
        }
        return [:]
    }
}
