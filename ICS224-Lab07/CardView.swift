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
    var groupSize: Int = 2
    var groupAmt: Int = 1
    @State var flipped: Bool = false
    @State var solved: Bool = false
    
    var body: some View {
        Button(action: {
            flipped = !flipped
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
        return  left.picture == right.picture &&
                left.groupSize == right.groupSize &&
                left.groupAmt == right.groupAmt
    }
}

struct CardView_Previews: PreviewProvider {
    @State static var picture: UIImage = UIImage(systemName: "hare")!
    static var previews: some View {
        CardView(picture: picture)
    }
}
