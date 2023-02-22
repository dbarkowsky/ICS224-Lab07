//
//  CardView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

struct CardView: Identifiable, View {
    let id = UUID()
    var picture: UIImage!
    @State var flipped: Bool
    @Binding var flipOccurred: Bool
    @State var solved: Bool = false
    
    
    var body: some View {
        Button(action: {
            flipped = !flipped
            flipOccurred = !flipOccurred
        }){
            Image(uiImage: flipped ? picture : UIImage(systemName: "circlebadge.fill")!)
                .scaledToFit()
        }
        .scaledToFit()
        .frame(width: 32.0, height: 32.0)
    }
}

extension CardView: Equatable {
    static func == (left: CardView, right: CardView) -> Bool {
        return  left.picture == right.picture
    }
}

struct CardView_Previews: PreviewProvider {
    @State static var picture: UIImage = UIImage(systemName: "hare")!
    @State static var flipped: Bool = false
    @State static var flipOccurred: Bool = false
    static var previews: some View {
        CardView(picture: picture, flipped: flipped, flipOccurred: $flipOccurred)
    }
}
