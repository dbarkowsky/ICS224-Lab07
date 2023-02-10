//
//  GameView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var treasures: CardList
    @State var matchedPairs: Int = 0
    @State var attempts: Int = 0
    
    var body: some View {
        Text("\(treasures.cards[0].name), \(treasures.cards[0].groupSize)")
        Text("Attempts: \(attempts)")
        Text("Total Remaining: \(determineTotalRemaining())")
    }
    
    func determineTotalRemaining() -> Int {
        return treasures.cards.reduce(0, {
            acc, curr in
            acc + curr.groupAmt
        }) - matchedPairs
    }
}

struct GameView_Previews: PreviewProvider {
    @StateObject static var treasures = CardList()
    static var previews: some View {
        GameView(treasures: treasures)
    }
}
