//
//  ScheduleView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2025-01-04.
//

import SwiftUI

struct ScheduleView: View {
    @State private var items = [
        ScheduleItem(itemName: "Wake Up", notificationEnabled: false),
        ScheduleItem(itemName: "Take Spike out", notificationEnabled: false),
        ScheduleItem(itemName: "Breakfast Time", notificationEnabled: false),
        ScheduleItem(itemName: "Give Allergy Medications", notificationEnabled: false),
        ScheduleItem(itemName: "Relax and Chill", notificationEnabled: false),
        ScheduleItem(itemName: "Play Time", notificationEnabled: false),
        ScheduleItem(itemName: "Nap Time", notificationEnabled: false),
        ScheduleItem(itemName: "Water and Snack Time", notificationEnabled: false)
    ]
    
    @State private var showAddItemView = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items.indices, id: \.self) { index in
                        NavigationLink(destination: EditItemView(item: $items[index])) {
                            HStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(items[index].itemName)
                                        .font(.headline)
                                    Text(dateToString(date: items[index].itemTime))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .onMove(perform: moveItem)
                    .onDelete(perform: deleteItem)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddItemView = true
                    }) {
                        Label("Add", systemImage: "plus")
                            .font(.headline)
                    }
                }
            }
            .sheet(isPresented: $showAddItemView) {
                AddItemView(items: $items)
            }
        }
        .accentColor(.teal)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    TabView {
        ScheduleView()
    }
}
