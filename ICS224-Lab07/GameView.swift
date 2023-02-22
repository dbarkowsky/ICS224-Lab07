//
//  GameView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI



struct GameView: View {
    @ObservedObject var treasures: TreasureList
    @ObservedObject var cards: CardList
    @State var matchedPairs: Int = 0
    @State var attempts: Int = 0
    @State var flipOccurred: Bool = false
    
    var body: some View {
        VStack{
            Grid(){
                let numOfRowsCols = cards.items.count
                ForEach(0..<numOfRowsCols, id: \.self){
                    row in
                    GridRow(){
                        ForEach(0..<numOfRowsCols, id: \.self){
                            col in
                            CardView(
                                picture: cards.items[row][col].picture,
                                flipped: cards.items[row][col].flipped,
                                flipOccurred: $flipOccurred
                            )
                        }
                    }
                }
            }
            
            Text("Attempts: \(attempts)")
            Text("Total Remaining: \(determineTotalRemaining())")
        }
        .onChange(of: flipOccurred){
            newValue in
            print("cards change")
            // increment attempts
            attempts += 1
            // check first flipped card
            // if any other cards of a different kind are flipped (but not solved), unflip all
            // if fewer than the group are flipped (but not solved), stay flipped for now
            // if enough of the same card are flipped (but not solved), mark them as solved, stay flipped
            // don't count blanks when flipping, they should never stay
            
        }
    }
            
    func determineTotalRemaining() -> Int {
        return treasures.items.reduce(0, {
            acc, curr in
            acc + curr.groupAmt
        }) - matchedPairs
    }
}

//struct GameView_Previews: PreviewProvider {
//    @StateObject static var treasures = TreasureList()
//    @StateObject static var cards = CardList()
//    static var previews: some View {
//        GameView(cards: cards)
//    }
//}
