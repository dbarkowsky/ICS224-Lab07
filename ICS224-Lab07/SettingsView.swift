//
//  SettingsView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

struct SettingsView: View {
//    @StateObject var treasures = CardList()
    @ObservedObject var treasures: CardList
    var body: some View {
        VStack{
            List($treasures.cards){
                $card in
                SettingsRowView(treasure: $card)
                .swipeActions(edge: .trailing){
                    Button(role: .destructive){
                        treasures.cards.removeAll(where: {$0.id == card.id})
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .navigationTitle("Treasures")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                    Button(
                        action: {
                            withAnimation {
                                
                                let newRow = Card(name: "Change me", groupSize: 2, groupAmt: 1)
                                treasures.cards.insert(newRow, at: 0)
                            }
                        }
                    ){
                        Image(systemName: "plus")
                    }.accessibilityIdentifier("PlusButton")
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @StateObject static var treasures = CardList()
    static var previews: some View {
        SettingsView(treasures: treasures)
    }
}
