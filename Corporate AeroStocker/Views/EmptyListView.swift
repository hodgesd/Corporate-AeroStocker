//
//  EmptyListView.swift
//  Corporate AeroStocker
//
//  Created by Derrick Hodges on 6/10/20.
//  Copyright © 2020 Derrick Hodges. All rights reserved.
//

import SwiftUI

struct EmptyListView: View {

    // MARK: - PROPERTIES

    @State private var isAnimated: Bool = false

    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image("illustration-no1")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(11)

                Text("Safety, Comfort, Reliability")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                } // VSTACK
                .padding(.horizontal)
                .opacity(isAnimated ? 1 : 0)
                .offset(y: isAnimated ? 0 : -50)
                .animation(.easeOut(duration: 1.5))
                .onAppear(perform: {
                    self.isAnimated.toggle()
                })
        } //: ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color("ColorBase"))
            .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
            .environment(\.colorScheme, .dark)
    }
}
