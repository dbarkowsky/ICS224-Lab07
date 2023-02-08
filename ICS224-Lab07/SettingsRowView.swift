//
//  SettingsRowView.swift
//  ICS224-Lab07
//
//  Created by ICS 224 on 2023-02-08.
//

import SwiftUI

struct SettingsRowView: View {
    @Binding var treasure: Card
    private let range = 2...10;
    var body: some View {
        HStack {
            Text("tester")
                .padding(0.0)
            Spacer()
                .padding(.trailing, 20.0)
            Stepper(value: Binding(
                get: {treasure.groupSize},
                set: {
                    newValue in
                    treasure.groupSize = newValue
                }), in: range, step: 1){
                Text("\(treasure.groupSize)/group")
                }
                .padding(20.0)
            Stepper(value: Binding(
                get: {treasure.groupAmt},
                set: {
                    newValue in
                    treasure.groupAmt = newValue
                }), in: range, step: 1){
                Text("\(treasure.groupAmt) group")
                }
                .padding(20.0)
        }
        .padding()
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    @State static var sampleCard: Card = Card(name: "flower", groupSize: 2, groupAmt: 1)
    static var previews: some View {
        SettingsRowView(treasure: $sampleCard)
    }
}
