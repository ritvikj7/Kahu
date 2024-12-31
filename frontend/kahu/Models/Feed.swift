//
//  Feed.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-31.
//

import Foundation


// Codable is a protocol in Swift that allows objects to be encoded and decoded to and from external representations such as JSON, XML, or Plist data
struct Feed: Codable {
    var posts: [Post]
}
