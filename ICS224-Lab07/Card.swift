//
//  Card.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-22.
//

import SwiftUI

/**
 A struct containing information on a single Card.
 - Parameters:
    - picture: An image to be displayed when rendered.
    - groupSize: The number of cards needed to constitute a match.
    - groupAmt: The number of matches for this particular picture.
 > The ``flipped`` and ``solved`` variables are used to identify this card's status when running checks for matching cards.
 */
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
        return  left.picture == right.picture &&
        left.flipped == right.flipped
    }
}
