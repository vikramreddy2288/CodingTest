//
//  Logger.swift
//  Feeds
//
//  Created by Vikram on 11/20/19.
//  Copyright © 2019 T-MOBILE USA, INC. All rights reserved.
//

import Foundation

/// This function is used to print logs only in debug mode
///
/// - Parameters:
///   - object: specifes about the object description
///   - file: file path
///   - function: function called
///   - line: and its line number
func tLog<T>( _ object: @autoclosure() -> T,
              _ file: String = #file,
              _ function: String = #function,
              _ line: Int = #line) {
    #if DEBUG
        let value = object()
        let stringRepresentation: String

        if let value = value as? CustomDebugStringConvertible {
            stringRepresentation = value.debugDescription
        } else if let value = value as? CustomStringConvertible {
            stringRepresentation = value.description
        } else {
            let msg = "tLog works for values that conform to CustomDebugStringConvertible or CustomStringConvertible"
            fatalError(msg)
        }

        let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
        let queue = Thread.isMainThread ? "UI" : "BG"
        let gFormatter = DateFormatter()
        gFormatter.dateFormat = "HH:mm:ss:SSS"
        let timestamp = gFormatter.string(from: Date())

        print("✅ \(timestamp) {\(queue)} \(fileURL) > \(function)[\(line)]: " + stringRepresentation + "\n")
    #endif
}
