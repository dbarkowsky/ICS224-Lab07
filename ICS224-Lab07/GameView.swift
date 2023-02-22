//
//  GameView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI


/**
 Displays the GameView.
 This contains a grid of CardView objects and two text fields
 Uses a flipOccured boolean to check for flips of any card.
 - Parameters:
    - treasures: A TreasureList object. Passed from parent view.
    - cards: A CardList object. Passed from parent view.
    - matchedPairs: A counter of how many pairs have been matched in the game.
    - attempts: A counter of how many attempts the player has made.
 */
struct GameView: View {
    @ObservedObject var treasures: TreasureList
    @ObservedObject var cards: CardList
    @Binding var matchedPairs: Int
    @Binding var attempts: Int
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
    
    /**
     Turns all cards that are not marked as solved face down.
     Also increments the user's number of attempts.
     */
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
    
    /**
     Marks any cards that are flipped and that match the supplied picture as solved.
     Also increments the user's number of attempts and matched pairs.
     - Parameters:
        - picture: A UIImage provided to check all flipped cards against.
     */
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
    
    /**
     Determines the number of remaining pairs yet to be solved.
     - Returns: (Int) The number of pairs unsolved.
     */
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
