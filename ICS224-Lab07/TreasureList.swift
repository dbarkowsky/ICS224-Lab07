//
//  TreasureList.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

/**
 Contains a list of Treasure items. Used in order to reference these items as an @ObservedObject.
 */
class TreasureList: ObservableObject {
    @Published var items = [Treasure]()
        
    /// Constructor when no treasures are given. Supplies one default treasure.
    init(){
        // App should always start with one example card item
        items.append(Treasure(name: "hare", groupSize: 2, groupAmt: 1))
    }
    
    /// Constructor when a list of treasures is supplied.
    init(treasures: [Treasure]){
        self.items = treasures
    }
}

extension TreasureList: Equatable {
    static func == (left: TreasureList, right: TreasureList) -> Bool {
        for i in 0..<left.items.count{
            if (left.items[i] != right.items[i]){
                return false
            }
        }
        return true
    }
}
