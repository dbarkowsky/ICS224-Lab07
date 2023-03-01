//
//  ICS224_Lab07App.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

/**
 Struct containing entire App.
 Displays the MainView.
 */
@main
struct ICS224_Lab07App: App {
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

struct Constants {
    static let defaultImage: UIImage = UIImage(systemName: "circlebadge")!
    static let hiddenImage: UIImage = UIImage(systemName: "circlebadge.fill")!
    static let unknownImage: UIImage = UIImage(systemName: "questionmark.circle")!
}
