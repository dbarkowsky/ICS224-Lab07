//
//  GameView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI



struct GameView: View {
    @State var cards: [CardView]
    @ObservedObject var treasures: TreasureList
    @State var matchedPairs: Int = 0
    @State var attempts: Int = 0
    @State var cardCounter: Int = 0
    
    var body: some View {
        VStack{
            Grid(){
                let numOfRows = Int(Double(cards.count).squareRoot())
                let rowLength = numOfRows
                ForEach(0..<numOfRows){
                    row in
                    GridRow(){
                        ForEach(0..<rowLength){
                            _ in
//                            CardView(
//                                picture: cards[cardCounter].picture,
//                                groupSize: cards[cardCounter].groupSize,
//                                groupAmt: cards[cardCounter].groupAmt
//                            )
                            makeCard(card: cards[cardCounter])
                        }
                    }
                }
            }
            
            Text("Attempts: \(attempts)")
            Text("Total Remaining: \(determineTotalRemaining())")
        }
    }
    
    func makeCard(card: CardView) -> CardView {
        cardCounter += 1
        return card
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
    @State static var cards: [CardView] = [CardView]()
    static var previews: some View {
        GameView(cards: cards, treasures: treasures)
    }
}
