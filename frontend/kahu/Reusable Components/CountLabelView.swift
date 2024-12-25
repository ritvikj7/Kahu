//
//  CountLabelView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-24.
//

import SwiftUI

struct CountLabelView: View {
    var count: String
    var label: String
    
    var body: some View {
        VStack {
            Text(count) // Dynamic count
                .font(.headline)
                .bold()
                .foregroundColor(.primary)
            Text(label) // Dynamic label
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}
