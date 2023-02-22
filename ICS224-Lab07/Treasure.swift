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
    - groupSize: The number of treasures needed to constitute a match.
    - groupAmt: The number of matches for this particular treasure.
 */
struct Treasure: Identifiable, Codable {
    var id = UUID()
    var name: String
    var groupSize: Int
    var groupAmt: Int
    
    init (name: String, groupSize: Int = 2, groupAmt: Int = 0){
        self.name = name
        self.groupSize = groupSize
        self.groupAmt = groupAmt
    }
}

extension Treasure: Equatable {
    static func == (left: Treasure, right: Treasure) -> Bool {
        return  true//left.items.flatMap == right.items.flatMap
    }
}
