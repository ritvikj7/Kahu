//
//  EditItemView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2025-01-05.
//

import SwiftUI

// View for editing an existing item
struct EditItemView: View {
    @Binding var item: ScheduleItem
    
    var body: some View {
        Form {
            TextField("Item Name", text: $item.itemName)
            DatePicker("Time", selection: $item.itemTime, displayedComponents: .hourAndMinute)
            Toggle("Notify Me", isOn: $item.notificationEnabled)
                .tint(.blue)
        }
        .navigationTitle("Edit Item")
    }
}

