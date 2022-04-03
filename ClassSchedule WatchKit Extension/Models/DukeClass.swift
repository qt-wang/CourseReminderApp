//
//  DukeClass.swift
//  watchapp WatchKit Extension
//
//  Created by Loaner on 2/27/22.
//

import Foundation
struct DukeClass: Codable, Hashable, Identifiable, CustomStringConvertible {
    var id: UUID = UUID()
    var name: String //ece564
    var description: String
    var startTime: String
    var endTime: String
    var isEnd: Bool
    var lastModified: Date?
    var address : String//gps location
    var roomNumber : String //hudson hall 215 //maybe a pair (building, room)
    var latitude: Float = 36.00166
    var longtitude: Float = -78.93781
}

let testClass = DukeClass(name: "ECE564", description: "Richard Telford's class", startTime: "12pm", endTime: "1:45pm", isEnd: false, lastModified: .now, address: "anywhere", roomNumber: "hudson hall 125")
