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
                                card: $cards.items[row][col]
                            )
                        }
                    }
                }
            }
            
            Text("Attempts: \(attempts)")
            Text(determineTotalRemaining() == 0 ? "Game Over. You Win!" : "Total Remaining: \(determineTotalRemaining())")
        }
        .navigationTitle("")
        .onChange(of: cards.items){
            _ in
            // increment attempts
            attempts += 1

            // convert cards to flat array temporarily
            let flatCards = cards.items.flatMap { $0 }
            // get all flipped cards
            let flippedCards = flatCards.filter { $0.flipped == true && $0.solved == false }
            
            // pause for user to see board
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                // if there is only one flipped card
                if (flippedCards.count == 1){
                    if flippedCards[0].picture == Constants.defaultImage{
                        markSingleCardAsSolved(id: flippedCards[0].id)
                    }
                } else
                // as long as there is at least one flipped card
                if (flippedCards.count > 1){
                    // get first card
                    let firstCard = flippedCards[0]

                    // if any other cards of a different kind are flipped (but not solved), unflip all
                    var differentCardsAreFlipped = false
                    for card in flippedCards{
                        if (card.picture != firstCard.picture && card.picture != Constants.defaultImage){
                            differentCardsAreFlipped = true
                        }
                    }
                    
                    // if enough of the same card are flipped (but not solved), mark them as solved, stay flipped
                    var aMatchIsFound = false
                    let groupSize = firstCard.groupSize
                    var cardCount = 0
                    for card in flippedCards{
                        if (card.picture == firstCard.picture && card.picture != Constants.defaultImage){
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
     First checks if any flipped cards are the blank inserts. Those should not flip back, so they are marked solved.
     Decrements attempts to counter trigger of onChange event.
     */
    func turnAllCardsFaceDown(){
        for row in 0..<cards.items.count {
            for col in 0..<cards.items[row].count {
                if (cards.items[row][col].flipped && cards.items[row][col].picture == Constants.defaultImage){
                    cards.items[row][col].solved = true
                }
                if (cards.items[row][col].solved == false){
                    cards.items[row][col].flipped = false
                }
            }
        }
        attempts -= 1
    }
    
    /**
     Marks any cards that are flipped and that match the supplied picture as solved.
     Also increments the user's matched pairs.
     Decrements attempts to counter trigger of onChange event.
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
        matchedPairs += 1
        attempts -= 1
    }
    
    /// Marks a single card as solved based on its UUID
    /// Decrements attempts to counter trigger of onChange event.
    /// - Parameter id: A unique id for the card you wish to mark solved
    func markSingleCardAsSolved(id: UUID){
        for row in 0..<cards.items.count {
            for col in 0..<cards.items[row].count {
                if (cards.items[row][col].id == id){
                    cards.items[row][col].solved = true
                }
            }
        }
        attempts -= 1
    }
    
    /**
     Determines the number of remaining pairs yet to be solved.
     - Returns: (Int) The number of pairs unsolved.
     */
    func determineTotalRemaining() -> Int {
        let remaining = treasures.items.reduce(0, {
            acc, curr in
            acc + curr.groupAmt
        }) - matchedPairs
        return remaining < 0 ? 0 : remaining
    }
}
