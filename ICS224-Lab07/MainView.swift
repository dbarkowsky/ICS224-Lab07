//
//  MainView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

public enum Pages{
    case START, GAME, SETTINGS
}

struct MainView: View {
    @State var visiblePage: Pages = Pages.START;
    @StateObject var treasures = TreasureList()
    
    func buildCardList(treasures: TreasureList) -> [CardView] {
        let uniqueCards = treasures.items.map{
            treasure in
            CardView(
                picture: UIImage(systemName: treasure.name) ?? UIImage(systemName: "questionmark.circle"),
                groupSize: treasure.groupSize,
                groupAmt: treasure.groupAmt
            )
        }
        var cardCount = uniqueCards.count
        
        var cards: [CardView] = []
        
        for card in uniqueCards{
            let amountToAdd = (card.groupSize * card.groupAmt)
            for _ in 0..<amountToAdd{
                cards.append(
                    CardView(
                        picture: card.picture,
                        groupSize: card.groupSize,
                        groupAmt: card.groupAmt
                    )
                )
            }
        }
        
        cardCount = cards.count
        let nextPerfectSquare = findNextPerfectSquare(currentCount: cardCount)
        
        for _ in cardCount..<nextPerfectSquare {
            cards.append(CardView(picture: UIImage(systemName: "circlebadge")))
        }
        
        return cards.shuffled()
    }
    
    func findNextPerfectSquare(currentCount: Int) -> Int {
        let next = Double(currentCount).squareRoot().rounded(.down) + 1
        return Int(next * next)
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                switch (visiblePage){
                case Pages.START:
                    StartView()
                case Pages.GAME:
                    GameView(cards: buildCardList(treasures: treasures), treasures: treasures)
                case Pages.SETTINGS:
                    SettingsView(treasures: treasures)
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar){
                    Button(
                        action: {
                            visiblePage = Pages.START
                        },
                        label: {
                            Text("Start")
                        }
                    )
                }
                ToolbarItem(placement: .bottomBar){ Spacer()}
                ToolbarItem(placement: .bottomBar){
                    Button(
                        action: {
                            visiblePage = Pages.GAME
                        },
                        label: {
                            Text("Game")
                        }
                    )
                }
                ToolbarItem(placement: .bottomBar){ Spacer()}
                ToolbarItem(placement: .bottomBar){
                    Button(
                        action: {
                            visiblePage = Pages.SETTINGS
                        },
                        label: {
                            Text("Settings")
                        }
                    )
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
