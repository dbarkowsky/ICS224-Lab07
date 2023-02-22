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
//    @EnvironmentObject var treasures: TreasureList
//    @EnvironmentObject var cards: CardList
    @StateObject var treasures = TreasureList()
    @StateObject var cards: CardList = CardList()
    
    var body: some View {
        NavigationStack{
            VStack{
                switch (visiblePage){
                case Pages.START:
                    StartView()
                case Pages.GAME:
                    GameView(treasures: treasures, cards: cards)
                case Pages.SETTINGS:
                    SettingsView(treasures: treasures, cards: cards)
                }
            }
            .onChange(of: visiblePage, perform: {
                newValue in
                if (newValue == Pages.GAME){
                    //cards.items = CardList.buildCardList(treasures: treasures)
                }
                print("page change")
            })
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
