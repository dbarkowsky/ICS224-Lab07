//
//  CardList.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

class CardList: ObservableObject {
    @Published var cards = [Card]()
        
    init(){
        // App should always start with one example card item
        cards.append(Card(name: "hare", groupSize: 2, groupAmt: 1))
    }
}
