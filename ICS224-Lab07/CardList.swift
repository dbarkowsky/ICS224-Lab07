//
//  CardList.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-22.
//

import SwiftUI

/**
 Contains a list of Card items. Used in order to reference these items as an @ObservedObject.
 */
class CardList: ObservableObject {
    @Published var items = [[Card]]()
        
    /**
     Constructor. Uses static method to build card array with starting treasures.
     */
    init(){
        // Should always have the default cards to start
        items = CardList.buildCardList(treasures: TreasureList())
    }
    
    /**
     Finds the next perfect square number above the provided number. e.g. 7 is not a perfect square, so finds 9.
     - Parameters:
        - currentCount: The current number (Int)
     - Returns: The next perfect square number. (Int)
     */
    static func findNextPerfectSquare(currentCount: Int) -> Int {
        let next = Double(currentCount).squareRoot().rounded(.down) + 1
        return Int(next * next)
    }
  
    /**
    Based on a provided list of treasures, builds a list of cards.
    Determines unique cards, adds the required number of those cards to get the desired pairs, then fills the list with blank cards to make a perfect square grid.
     - Parameters:
        - treasures: A TreasureList that contains an array of Treasure items
     - Returns: A 2D array of Card items.
     */
    static func buildCardList(treasures: TreasureList) -> [[Card]] {
        let uniqueCards = treasures.items.map{
            treasure in
            Card(
                picture: UIImage(systemName: treasure.name) ?? Constants.unknownImage,
                groupSize: treasure.groupSize,
                groupAmt: treasure.groupAmt
            )
        }
        var cardCount = uniqueCards.count
        
        var cards: [Card] = []
        
        for card in uniqueCards{
            let amountToAdd = (card.groupSize * card.groupAmt)
            for _ in 0..<amountToAdd{
                cards.append(
                    Card(
                        picture: card.picture,
                        groupSize: card.groupSize,
                        groupAmt: card.groupAmt
                    )
                )
            }
        }
        
        cardCount = cards.count
        let nextPerfectSquare = CardList.findNextPerfectSquare(currentCount: cardCount)
        let squaredValue = Int(Double(nextPerfectSquare).squareRoot())
        
        for _ in cardCount..<nextPerfectSquare {
            cards.append(Card(picture: Constants.defaultImage))
        }
        
        cards = cards.shuffled()
        var cardGrid: [[Card]] = [[Card]]()
        
        // Break into 2D array
        for i in stride(from: 0, to: cards.count, by: squaredValue){
            var tempRow: [Card] = [Card]()
            for j in 0..<squaredValue {
                tempRow.append(cards[i + j])
            }
            cardGrid.append(tempRow)
        }
        
        return cardGrid
    }
    
    /// Returns the number of solved cards that aren't blanks
    /// - Returns: (Int) Number of non-blank solved cards
    func howManySolvedCards() -> Int {
        let flatCards = items.flatMap{ $0 }
        let solvedCards = flatCards.filter { $0.solved == true && $0.picture != Constants.defaultImage }
        
        return solvedCards.count
    }
    
    /// Returns the number of cards that aren't blanks
    /// - Returns: (Int) Number of non-blank cards
    func howManyFaceCards() -> Int {
        let flatCards = items.flatMap{ $0 }
        let faceCards = flatCards.filter { $0.picture != Constants.defaultImage }
        
        return faceCards.count
    }
}

extension CardList: Equatable {
    static func == (left: CardList, right: CardList) -> Bool {
        let leftFlat = left.items.flatMap { $0 }
        let rightFlat = right.items.flatMap { $0 }
        for i in 0..<leftFlat.count{
            if (leftFlat[i] != rightFlat[i]){
                return false
            }
        }
        return true
    }
}
