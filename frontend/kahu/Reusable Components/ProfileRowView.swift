//
//  ProfileRowView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-24.
//

import SwiftUI

struct ProfileRowView: View {
    var label: String
    var labelInfo: String
    
    var body: some View {
        HStack{
            Text(label)
                .font(.body)
                .foregroundColor(.secondary)
            Spacer()
            Text(labelInfo)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}
