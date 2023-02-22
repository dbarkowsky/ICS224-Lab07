//
//  MainView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

/**
 Enum object to define view states.
 */
public enum Pages{
    case START, GAME, SETTINGS
}

/**
 Main view for the application.
 Holds a state for which page should be visiable and two state objects for Treasures and Cards
 The toolbar for the three views is also contained here.
 */
struct MainView: View {
    @State var visiblePage: Pages = Pages.START;
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
