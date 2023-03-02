//
//  Treasure.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

/**
An object to hold data on an individual Treasure.
 - Parameters:
    - name: The name of the treasure. (String)
    - groupSize: The number of treasures needed to constitute a match. (Int)
    - groupAmt: The number of matches for this particular treasure. (Int)
 */
struct Treasure: Identifiable, Codable {
    var id = UUID()
    var name: String
    var groupSize: Int
    var groupAmt: Int
    
    /// Initializes class with all parameters
    /// - Parameters:
    ///   - name: The name of the treasure. (String)
    ///   - groupSize: The number of treasures needed to constitute a match. (Int)
    ///   - groupAmt: The number of matches for this particular treasure. (Int)
    init (name: String, groupSize: Int = 2, groupAmt: Int = 1){
        self.name = name
        self.groupSize = groupSize
        self.groupAmt = groupAmt
    }
}

extension Treasure: Equatable {
    static func == (left: Treasure, right: Treasure) -> Bool {
        return  left.name == right.name &&
        left.groupSize == right.groupSize &&
        left.groupAmt == right.groupAmt
    }
}
