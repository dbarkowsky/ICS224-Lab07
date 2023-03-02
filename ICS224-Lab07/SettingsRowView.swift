//
//  SettingsRowView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

/**
 Displays a single row of a treasure in the SettingsView.
 Each row is composed of a TextEditor and two Steppers.
 - Parameters:
    - treasure: The treasure to be displayed (Treasure)
 */
struct SettingsRowView: View {
    @Binding var treasure: Treasure
    private let groupRange = 2...10;
    private let amtRange = 1...10;
    
    var body: some View {
        ScrollView(.horizontal){
            Grid(){
                GridRow(){
                    TextField("Enter icon name" ,text: Binding(
                        get: {
                            treasure.name
                        },
                        set: {
                            newValue in
                            treasure.name = newValue
                        }
                    ))
                    .textInputAutocapitalization(.never)
                    .frame(minWidth: 200, maxWidth: .infinity, alignment: .leading)

                    
                    Stepper(value: Binding(
                        get: {treasure.groupSize},
                        set: {
                            newValue in
                            treasure.groupSize = newValue
                        }), in: groupRange, step: 1){
                            Text("\(treasure.groupSize)/group")
                                .frame(minWidth: 80)
                        }
                        .padding(.horizontal, 7.0)
                        .frame(alignment: .trailing)
                    Stepper(value: Binding(
                        get: {treasure.groupAmt},
                        set: {
                            newValue in
                            treasure.groupAmt = newValue
                        }), in: amtRange, step: 1){
                            Text("\(treasure.groupAmt) group\(treasure.groupAmt > 1 ? "s" : "")")
                                .frame(minWidth: 80)
                        }
                        .padding(.horizontal, 7.0)
                        .frame(alignment: .trailing)
                }
                .alignmentGuide(.trailing, computeValue: { _ in
                    return 0
                })
                .padding()
            }
            .scaledToFill()
        }
    }
}
