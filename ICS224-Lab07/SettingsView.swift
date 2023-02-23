//
//  SettingsView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

/**
 Displays the list of Treasures. Includes a + button to add additional Treasures.
 Uses an ``updateOccurred`` boolean to check for changes to the treasures list.
 - Parameters:
    - treasures: A TreasureList object. Passed from parent view.
    - cards: A CardList object. Passed from parent view.
    - matchedPairs: A counter of how many pairs have been matched in the game.
    - attempts: A counter of how many attempts the player has made.
 */
struct SettingsView: View {
    @ObservedObject var treasures: TreasureList
    @ObservedObject var cards: CardList
    @Binding var matchedPairs: Int
    @Binding var attempts: Int
    @State var updateOccurred: Bool = false
    
    var body: some View {
        VStack{
            List{
                ForEach($treasures.items){
                    $item in
                    SettingsRowView(treasure: $item)
                }
                .onMove{
                    treasures.items.move(fromOffsets: $0, toOffset: $1)
                }
                .onDelete{
                    if let id = $0.first {
                        treasures.items.remove(at: id)
                    }
                }
            }
        }
        .onChange(of: treasures.items, perform: {
            _ in
            cards.items = CardList.buildCardList(treasures: treasures)
            attempts = 0
            matchedPairs = 0
        })
        .navigationTitle("Treasures")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing){
                    Button(
                        action: {
                            withAnimation {
                                updateOccurred = true
                                let newRow = Treasure(name: "Change me", groupSize: 2, groupAmt: 1)
                                treasures.items.insert(newRow, at: 0)
                            }
                        }
                    ){
                        Image(systemName: "plus")
                    }.accessibilityIdentifier("PlusButton")
                
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    @StateObject static var treasures = TreasureList()
//    @StateObject static var cards: CardList = CardList()
//    static var previews: some View {
//        SettingsView(treasures: treasures, cards: cards)
//    }
//}
