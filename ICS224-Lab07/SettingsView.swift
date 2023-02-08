//
//  SettingsView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var treasures = CardList()
    
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
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
