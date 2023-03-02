//
//  SettingsView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

/**
 Displays the list of Treasures. Includes a + button to add additional Treasures.
 - Parameters:
    - treasures: A TreasureList object. Passed from parent view. (TreasureList)
    - cards: A CardList object. Passed from parent view. (CardList)
    - matchedPairs: A counter of how many pairs have been matched in the game. (Int)
    - attempts: A counter of how many attempts the player has made. (Int)
 */
struct SettingsView: View {
    @ObservedObject var treasures: TreasureList
    @ObservedObject var cards: CardList
    @Binding var matchedPairs: Int
    @Binding var attempts: Int
    
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
                                let newRow = Treasure(name: "")
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
