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
    - cards: A CardList object to give access to the entire list of cards and make appropriate changes. (CardList)
    - row: This card's row location (Int)
    - col: This card's column location (Int)
    - flipOccurred: Used to track whether this card changes anything. Observed by parent view. (Bool)
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

//struct CardView_Previews: PreviewProvider {
//    @State static var picture: UIImage = UIImage(systemName: "hare")!
//    @State static var flipped: Bool = false
//    @State static var flipOccurred: Bool = false
//    static var previews: some View {
//        CardView( flipOccurred: $flipOccurred)
//    }
//}
