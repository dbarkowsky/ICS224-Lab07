//
//  Card.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-22.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    var picture: UIImage
    var groupSize: Int
    var groupAmt: Int
    var flipped: Bool
    var solved: Bool
    
    init (picture: UIImage, groupSize: Int = 2, groupAmt: Int = 0){
        self.picture = picture
        self.groupSize = groupSize
        self.groupAmt = groupAmt
        self.flipped = false
        self.solved = false
    }
}

extension Card: Equatable {
    static func == (left: Card, right: Card) -> Bool {
        return  left.picture == right.picture
    }
}
