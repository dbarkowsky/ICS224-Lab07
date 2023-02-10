//
//  GameView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var treasures: TreasureList
    @State var matchedPairs: Int = 0
    @State var attempts: Int = 0
    
    var body: some View {
        Text("\(treasures.items[0].name), \(treasures.items[0].groupSize)")
        Text("Attempts: \(attempts)")
        Text("Total Remaining: \(determineTotalRemaining())")
    }
    
    func determineTotalRemaining() -> Int {
        return treasures.items.reduce(0, {
            acc, curr in
            acc + curr.groupAmt
        }) - matchedPairs
    }
}

struct GameView_Previews: PreviewProvider {
    @StateObject static var treasures = TreasureList()
    static var previews: some View {
        GameView(treasures: treasures)
    }
}
