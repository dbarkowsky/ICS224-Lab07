//
//  StartView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

/**
 Contains the instructions for the game. No interaction required.
 */
struct StartView: View {
    var body: some View {
        VStack (alignment: .center){
            Text("Welcome to the ICS 224 Memory Game!")
                .padding(EdgeInsets(
                    top: 15,
                    leading: 40,
                    bottom: 5,
                    trailing: 40))
                .font(.system(size: 20, weight: .semibold))
            
            Text("The aim is to uncover identical images, without uncovering a mismatching image in the process. If a certain number of identical images have been revealed, they are removed from the game. (The exact number of identical images that must be uncovered before they are removed depends on the image and can be set from the Settings tab.) If a mismatched image is selected, all revealed images are hidden again. The game ends when all images have been removed from the game.")
                .padding()
                .font(.system(size: 20))
                
            Spacer()
        }
        .navigationTitle("")
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
