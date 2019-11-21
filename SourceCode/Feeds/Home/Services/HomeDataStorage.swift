//
//  HomeDataStorage.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import UIKit

/*
As a better approach would like to use core data to save view models and retrive them back,
for time being due to time constraints saving the data to disk and retriving it back
Same Applies for Orientation support as well
 */

//This class is used to save home feeds data to disk and retrive it back
class HomeDataStorage: NSObject {
    
    // Name of the file in the disk
    let fileName = "homeFeeds.txt"
    
    // Used to get documents directory path
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // writing the data to the file in the disk
    func writeDataToFile(data: String) {
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            try data.write(to: filePath, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            tLog("save data to a file on disk failed")
        }
    }
    
    // retreving the data from the file in the disk
    func getHomeFeedsFromDisk() -> Data? {
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let text = try String(contentsOf: filePath, encoding: .utf8)
            let data = text.data(using: .utf8)
            return data
        }
        catch {
            return nil
        }
    }
}
