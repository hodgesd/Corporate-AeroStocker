//
//  ContentView.swift
//  Corporate AeroStocker
//
//  Created by Derrick Hodges on 6/7/20.
//  Copyright © 2020 Derrick Hodges. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES

    // Variable to access permanent store

    @Environment(\.managedObjectContext) var managedObjectContext

    // Fetch Request to

    @FetchRequest(entity: StockItem.entity(), sortDescriptors: [NSSortDescriptor (keyPath: \StockItem.name, ascending: true)]) var stockItems: FetchedResults<StockItem>

    @State private var showingAddItemView: Bool = false
    @State private var animatingButton: Bool = false

    /// Group function
    /// - Parameter result: Unordered stock items
    /// - Returns: Stock Items grouped by compartment and sorted by name
    func group(_ result : FetchedResults<StockItem>)-> [[StockItem]] {

        return Dictionary(grouping: result) { $0.compartment!.sorted() }
            .sorted {$0.key.first! < $1.key.first!}
            .map {$0.value}
    }

    // MARK: - BODY

    var body: some View {

        NavigationView {
            ZStack {
                List {
                    ForEach (group(stockItems), id:\.self) { (section: [StockItem]) in
                        Section (header: Text (section[0].compartment!)) {
                            ForEach(section, id:\.self) {stockItem in
                                HStack{
                                    Text(stockItem.name ?? "Unknown")
                                        .fontWeight(.semibold)
                                        .font(.headline)
                                        .padding (.horizontal, 7)
                                    TextCapsuleView(tag: stockItem.category ?? "Unknown")
                                } //: HSTACK    }

                            } //: FOREACH
                                .onDelete(perform: self.deleteStockItem)
                        } //: SECTION
                    } //: FOREACH
                } //: LIST
                    .navigationBarTitle("Inventory", displayMode: .inline)
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing:
                        Button(action: {
                            // Show add item view
                            self.showingAddItemView.toggle()
                        }) {
                            Image(systemName: "plus")
                        } // :ADD BUTTON
                            .sheet(isPresented: $showingAddItemView) {
                                AddItemView().environment(\.managedObjectContext, self.managedObjectContext)
                                    .environment(\.managedObjectContext.automaticallyMergesChangesFromParent, true)
                        }
                )
                // MARK: - NO STOCK ITEMS
//                if stockItems.count == 0 {
//                    EmptyListView()
//                }
            } //: ZSTACK
                .sheet(isPresented: $showingAddItemView) {
                    AddItemView().environment(\.managedObjectContext, self.managedObjectContext)
            }
            .overlay(
                ZStack {
                    Group{
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width:68, height: 68, alignment: .center)
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                Button(action: {
                    self.showingAddItemView.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .background(Circle().fill(Color("ColorBase")))
                        .frame(width: 48, height: 48, alignment: .center)
                } //: BUTTON
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                } //: ZSTACK
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                    , alignment: .bottomTrailing
            )
        } //: NAVIGATION
    }

    // MARK: - FUNCTIONS

    private func deleteStockItem(at offsets: IndexSet) {
        for index in offsets {
            let stockItem = stockItems[index]
            managedObjectContext.delete(stockItem)

            do {
                try managedObjectContext.save()
            } catch {
                print (error)


            }
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
            .previewDevice("iPhone 11 Pro")
    }
}
