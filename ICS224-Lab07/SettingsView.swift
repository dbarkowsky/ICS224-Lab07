//
//  SettingsView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var treasures: TreasureList
    var body: some View {
        VStack{
            List($treasures.items){
                $item in
                SettingsRowView(treasure: $item)
                .swipeActions(edge: .trailing){
                    Button(role: .destructive){
                        treasures.items.removeAll(where: {$0.id == item.id})
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

struct SettingsView_Previews: PreviewProvider {
    @StateObject static var treasures = TreasureList()
    static var previews: some View {
        SettingsView(treasures: treasures)
    }
}
