//
//  DukePerson.swift
//  watchapp WatchKit Extension
//
//  Created by Loaner on 2/27/22.
//

import Foundation
struct DukePerson: Codable, Hashable, Identifiable, CustomStringConvertible {
    var id: UUID = UUID()
    var firstName: String
    var lastName: String
    var description: String
    var FriendList : [String]
    var Schedule : [String : DukeClass]
    var netId : String
}

let testDukePerson = DukePerson(firstName: "richard", lastName: "richard", description: "test person", FriendList: ["feng"], Schedule: ["testclass" : testClass], netId: "rochard")
