//
//  ICS224_Lab07App.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

@main
struct ICS224_Lab07App: App {
    @StateObject var treasures = TreasureList()
    @StateObject var cards: CardList = CardList()
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(treasures).environmentObject(cards)
        }
    }
}
