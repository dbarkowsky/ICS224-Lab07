//
//  CardList.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-22.
//

import SwiftUI

class CardList: ObservableObject {
    @Published var items = [[Card]]()
        
    init(){
        // Should always have the default cards to start
        items = CardList.buildCardList(treasures: TreasureList())
    }
    
    static func findNextPerfectSquare(currentCount: Int) -> Int {
        let next = Double(currentCount).squareRoot().rounded(.down) + 1
        return Int(next * next)
    }
    
    static func buildCardList(treasures: TreasureList) -> [[Card]] {
        let uniqueCards = treasures.items.map{
            treasure in
            Card(
                picture: (UIImage(systemName: treasure.name) ?? UIImage(systemName: "questionmark.circle"))!,
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
            cards.append(Card(picture: UIImage(systemName: "circlebadge")!))
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
}

extension CardList: Equatable {
    static func == (left: CardList, right: CardList) -> Bool {
        return  true//left.items.flatMap == right.items.flatMap
    }
}
