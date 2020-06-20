//
//  AddItemView.swift
//  Corporate AeroStocker
//
//  Created by Derrick Hodges on 6/7/20.
//  Copyright © 2020 Derrick Hodges. All rights reserved.
//

import SwiftUI

struct AddItemView: View {

    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext

    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var category: String = "Beverages"
//    @State private var count: String = "Each"
    @State private var compartment: String = "Galley"
    @State private var full: Int16 = 0
//    @State private var need: Int16 = 0
//    @State private var onhand: Int = 6

//    let counts = ["Each", "Cases"]
    let categories = ["Beverages", "Utinsils", "Snacks"]
    let zones = ["Galley", "Credenza", "Lav", "Overstock"]
//    let fulls = [0,1,2,3,4,5,6,7,8,9,10]

    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""

    // MARK: - BODY

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20){
                    // MARK: - ITEM NAME

                    TextField("Item", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size:24, weight:.bold, design: .default))

                    PickerBinding(pickerTitle: "Category", pickerSelection: $category, pickerArray: categories)

                    PickerBinding(pickerTitle: "Zone", pickerSelection: $compartment, pickerArray: zones)

//                    PickerBinding(pickerTitle: "Full", pickerSelection: $full, pickerArray: fulls)

                    Picker(selection: $full, label: Text("Full")) {
                        ForEach(1...10, id: \.self) { ix in
                            Text("\(ix)").tag(ix)
                        }
                    }.pickerStyle(SegmentedPickerStyle())

//                    PickerBinding(pickerTitle: "Count", pickerSelection: $count, pickerArray: counts)

                    //                ScrollView(.horizontal) {
                    //                    HStack(spacing: 20) {
                    //                        ForEach(1..<10) {
                    //                            Text("\($0) Items")
                    //                                .foregroundColor(.white)
                    //                                .font(.headline)
                    //                                .frame(width: 80, height: 80)
                    //                                .background(Color.orange)
                    //
                    //                        }
                    //                    }
                    //                } //: SCROLLVIEW

                    Button(action: {
                        if self.name != "" {
                            let stockItem = StockItem (context: self.managedObjectContext)
                            stockItem.name = self.name
                            stockItem.category = self.category
                            stockItem.compartment = self.compartment
//                            stockItem.full = self.full
//                            stockItem.need = 0

                            do {
                                try self.managedObjectContext.save()

                            } catch {
                                print (error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "The stock item must have a name."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()

                    }) {
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design:.default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                        .cornerRadius(9)
                            .foregroundColor(Color.white)
                    } //: BUTTON
                } //: VStack
                    .padding(.horizontal)
                    .padding(.vertical, 30
                )

                Spacer()
            } //: VSTACK
                .navigationBarTitle("New Item", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()

                    }) {
                        Image(systemName: "xmark")
                    }
            )
                .alert(isPresented: $errorShowing) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))

            }
        } //: NAVIGATION
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
