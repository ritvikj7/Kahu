//
//  EditableRowView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-25.
//
import SwiftUI

struct EditableRowView: View {
    var label: String
    @Binding var text: String
    // @Binding creates a two-way connection to a value that's stored somewhere else. It's like creating a reference instead of copying the value. When you type in the TextField, it needs to modify the original data, not a copy. Without @Binding, you'd only have a one-way connection (you could read the value but not change it)
    // In SwiftUI, @Binding is used to create a two-way connection between a parent view and a child view. This means that changes made in the child view (like typing in a TextField) will be reflected in the parent view, and vice versa.

    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(.secondary)
            Spacer()
            TextField("Enter \(label.lowercased())", text: $text)
                .font(.body)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 200)
        }
    }
}
