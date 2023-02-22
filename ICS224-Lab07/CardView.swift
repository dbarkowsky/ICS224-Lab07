//
//  CardView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

struct CardView: Identifiable, View {
    let id = UUID()
    @ObservedObject var cards: CardList
    var row: Int
    var col: Int
    @Binding var flipOccurred: Bool    
    
    var body: some View {
        Button(action: {
            cards.items[row][col].flipped = !cards.items[row][col].flipped
            flipOccurred = !flipOccurred
        }){
            Image(uiImage: cards.items[row][col].flipped ? cards.items[row][col].picture : UIImage(systemName: "circlebadge.fill")!)
                .scaledToFit()
        }
        .scaledToFit()
        .frame(width: 32.0, height: 32.0)
    }
}

extension CardView: Equatable {
    static func == (left: CardView, right: CardView) -> Bool {
        return  left.cards.items[left.row][left.col].picture == right.cards.items[right.row][right.col].picture
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
