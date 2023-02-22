//
//  TreasureList.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

class TreasureList: ObservableObject {
    @Published var items = [Treasure]()
        
    init(){
        // App should always start with one example card item
        items.append(Treasure(name: "hare", groupSize: 2, groupAmt: 1))
    }
    
    init(treasures: [Treasure]){
        self.items = treasures
    }
}

extension TreasureList: Equatable {
    static func == (left: TreasureList, right: TreasureList) -> Bool {
        return  true//left.items.flatMap == right.items.flatMap
    }
}
