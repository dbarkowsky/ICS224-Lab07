//
//  CardView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI
/**
 Displays a single card as an image.
 - Parameters:
    - card: A Card object to give access to the relevant cards and make appropriate changes. (Card)
 */
struct CardView: Identifiable, View {
    let id = UUID()
    @Binding var card: Card
    
    var body: some View {
        Button(action: {
            card.flipped = true
        }){
            Image(uiImage: card.solved ? Constants.defaultImage : card.flipped ? card.picture : Constants.hiddenImage)
                .scaledToFit()
        }
        .scaledToFit()
        .frame(width: 32.0, height: 32.0)
    }
}

extension CardView: Equatable {
    static func == (left: CardView, right: CardView) -> Bool {
        return  left.card == right.card
    }
}
