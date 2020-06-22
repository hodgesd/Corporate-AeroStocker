//
//  ResupplyView.swift
//  Corporate AeroStocker
//
//  Created by Derrick Hodges on 6/20/20.
//  Copyright © 2020 Derrick Hodges. All rights reserved.
//

import SwiftUI

struct ResupplyView: View {
    //: MARK- Parameters

    var need: Int16

    var body: some View {
        Text("\(need)")
            .font(.body)
            .fontWeight(.semibold)
            .foregroundColor(Color(UIColor.white))
            .padding(2)
            .frame(minWidth: 35)
            .background(Color.blue)
            .overlay(
                Capsule(style: .circular)
                    .stroke(Color(UIColor.secondaryLabel),
                            lineWidth: 0.75)
            )
        .clipShape(Capsule())
            .animation(.easeInOut)
    }
}

struct ResupplyView_Previews: PreviewProvider {
    static var previews: some View {
        ResupplyView(need: 8)
    }
}
