//
//  PickerBinding.swift
//  Corporate AeroStocker
//
//  Created by Derrick Hodges on 6/7/20.
//  Copyright © 2020 Derrick Hodges. All rights reserved.
//

import SwiftUI

struct PickerBinding: View {
    // MARK: PROPERTIES
    public var pickerTitle: String
    @Binding var pickerSelection: String
    public var pickerArray: [String]

    // MARK: BODY

    var body: some View {

        Picker(pickerTitle, selection: $pickerSelection) {
            ForEach(pickerArray, id:\.self) {
                Text($0)
            }
        } // :PICKER
        .pickerStyle(SegmentedPickerStyle())
    }
}
//
//struct PickerBinding_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerBinding(pickerTitle: "Categories", pickerArray: pickerArray)
//    }
//}
