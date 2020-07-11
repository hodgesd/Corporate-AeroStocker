//
//  FilteredListView.swift
//  Corporate AeroStocker
//
//  Created by Derrick Hodges on 6/23/20.
//  Copyright © 2020 Derrick Hodges. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredListView: View {

    var fetchRequest: FetchRequest<StockItem>

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in

        }
    }


    init(filter: String) {
        fetchRequest = FetchRequest<StockItem>(entity: StockItem.entity(), sortDescriptors: [], predicate: NSPredicate(format: "category BEGINSWITH %@", filter))
    }
}
