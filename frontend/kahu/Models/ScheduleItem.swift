//
//  ScheduleItem.swift
//  kahu
//
//  Created by Ritvik Joshi on 2025-01-04.
//
import Foundation


struct ScheduleItem: Codable, Hashable {
    var itemName: String
    var itemTime = Date()
    var notificationEnabled: Bool
}
