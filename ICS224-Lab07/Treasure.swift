//
//  Treasure.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

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
