//
//  AddItemView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2025-01-05.
//

import SwiftUI

// View for adding a new item
struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var items: [ScheduleItem]
    @State private var newItemName = ""
    @State private var newItemTime = Date()
    @State var notificationsEnabled: Bool = false


    var body: some View {
        NavigationView {
            Form {
                TextField("Item Name", text: $newItemName)
                DatePicker("Time", selection: $newItemTime, displayedComponents: .hourAndMinute)
                Toggle("Notify Me", isOn: $notificationsEnabled)
                    .tint(.blue)
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newItem = ScheduleItem(itemName: newItemName, itemTime: newItemTime, notificationEnabled: notificationsEnabled)
                        items.append(newItem)
                        dismiss()
                    }
                    .disabled(newItemName.isEmpty)
                }
            }
        }
    }
}
