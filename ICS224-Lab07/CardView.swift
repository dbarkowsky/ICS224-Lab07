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
    var body: some View {
        Button(action: {
            
        }){
            Image(uiImage: picture)
                .scaledToFit()
        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(.blue, lineWidth: 2)
//        )
    }
}

struct CardView_Previews: PreviewProvider {
    @State static var picture: UIImage = UIImage(systemName: "hare")!
    static var previews: some View {
        CardView(picture: picture)
    }
}
