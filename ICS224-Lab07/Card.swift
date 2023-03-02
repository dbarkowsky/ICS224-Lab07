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
    - picture: An image to be displayed when rendered. (UIImage)
    - groupSize: The number of cards needed to constitute a match. (Int)
    - groupAmt: The number of matches for this particular picture. (Int)
    - flipped: Whether or not the card is in the flipped state (Bool)
    - solved: Whether or not the card is in the solved state (Bool)
 */
struct Card: Identifiable {
    var id = UUID()
    var picture: UIImage
    var groupSize: Int
    var groupAmt: Int
    var flipped: Bool
    var solved: Bool
    
    ///  Constructor with picture, groupSize, and groupAmt parameters
    /// - Parameters:
    ///   - picture: An image to be displayed when rendered.
    ///   - groupSize: The number of cards needed to constitute a match.
    ///   - groupAmt: The number of matches for this particular picture.
    init (picture: UIImage, groupSize: Int = 2, groupAmt: Int = 1){
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
        left.flipped == right.flipped &&
        left.solved == right.solved
    }
}
