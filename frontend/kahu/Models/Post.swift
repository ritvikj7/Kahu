//
//  Post.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-31.
//

import Foundation

struct Post: Codable {
    var caption: String
    var location: String
    var date: String
    var base64Image: String
}
