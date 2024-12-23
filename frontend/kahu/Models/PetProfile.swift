//
//  PetProfile.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-21.
//

import Foundation


// Codable is a protocol in Swift that allows objects to be encoded and decoded to and from external representations such as JSON, XML, or Plist data
struct PetProfile: Codable {
    var name: String
    var breed: String
    var age: Int
    var birthday: String
    var weight: Int
    var gender: String
}


// Structs are value types, meaning when you assign or pass a struct, it is copied rather than referenced.
// Structs encourage immutability, as their properties can be declared as constants (let) or variables (var).
// Structs in Swift can have methods, computed properties, and even initializers, making them highly capable
