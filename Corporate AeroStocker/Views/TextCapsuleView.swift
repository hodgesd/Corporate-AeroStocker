//
//  TextCapsuleView.swift
//  Corporate AeroStocker
//
//  Created by Derrick Hodges on 6/12/20.
//  Copyright © 2020 Derrick Hodges. All rights reserved.
//

import SwiftUI

struct TextCapsuleView: View {
    var tag: String


    var body: some View {
        VStack {
            Text(tag)
                .font(.caption)
                .foregroundColor(Color(UIColor.secondaryLabel))
                .padding(.horizontal, 2)
                //            .frame(minWidth: 62)
                .overlay(
                    Capsule().stroke(Color(UIColor.secondaryLabel), lineWidth: 0.75)
            )
        }
    }
}

struct TextCapsuleView_Previews: PreviewProvider {
    static var previews: some View {
        TextCapsuleView(tag: "Snacks")
        
    }
}
