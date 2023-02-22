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
                                cards: cards,
                                row: row,
                                col: col,
                                flipOccurred: $flipOccurred
                            )
                        }
                    }
                }
            }
            
            Text("Attempts: \(attempts)")
            Text("Total Remaining: \(determineTotalRemaining())")
        }
        .navigationTitle("")
        .onChange(of: flipOccurred){
            _ in
            print("cards change")
            // convert cards to flat array temporarily
            let flatCards = cards.items.flatMap { $0 }//Array(cards.items).joined()
            // get all flipped cards
            let flippedCards = flatCards.filter { $0.flipped == true && $0.solved == false}
            
            // pause for user to see board
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                // as long as there is at least one flipped card
                if (flippedCards.count > 0){
                    // get first card
                    let firstCard = flippedCards[0]
                    // if it's only a blank that was flipped, flip it back
                    if (firstCard.picture == UIImage(systemName: "circlebadge") && flippedCards.count == 1){
                        turnAllCardsFaceDown()
                    }
                    // if any other cards of a different kind are flipped (but not solved), unflip all
                    var differentCardsAreFlipped = false
                    for card in flippedCards{
                        if (card != firstCard){
                            differentCardsAreFlipped = true
                        }
                    }
                    // if enough of the same card are flipped (but not solved), mark them as solved, stay flipped
                    var aMatchIsFound = false
                    let groupSize = firstCard.groupSize
                    var cardCount = 0
                    for card in flippedCards{
                        if (card.picture == firstCard.picture){
                            cardCount += 1
                        }
                    }
                    if (cardCount == groupSize){
                        aMatchIsFound = true
                    }
                    
                    if (differentCardsAreFlipped){
                        turnAllCardsFaceDown()
                    } else if (aMatchIsFound){
                        markCardsAsSolved(picture: firstCard.picture)
                    } else {
                        // if fewer than the group are flipped (but not solved), stay flipped for now
                        // do nothing
                    }
                }
            }
        }
    }
    
    func turnAllCardsFaceDown(){
        for row in 0..<cards.items.count {
            for col in 0..<cards.items[row].count {
                if (cards.items[row][col].solved == false){
                    cards.items[row][col].flipped = false
                }
            }
        }
        // increment attempts
        attempts += 1
    }
    
    func markCardsAsSolved(picture: UIImage){
        for row in 0..<cards.items.count {
            for col in 0..<cards.items[row].count {
                if (cards.items[row][col].picture == picture && cards.items[row][col].flipped == true){
                    cards.items[row][col].solved = true
                }
            }
        }
        // increment attempts
        attempts += 1
        matchedPairs += 1
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
