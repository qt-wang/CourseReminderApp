//
//  ClassInfoVM.swift
//  ClassSchedule WatchKit Extension
//
//  Created by student on 3/14/22.
//

import Foundation
import Combine
import SwiftUI

class ClassInfoVM: ObservableObject {
    
    @Published var Duke_Class: DukeClass
    @Published var Duke_Person: DukePerson
    @ObservedObject var DataBase: ModelData
    private var editing = false

    init(duke_class: DukeClass, duke_person: DukePerson, database: ModelData){
        self.Duke_Class = duke_class
        self.Duke_Person = duke_person
        self.DataBase = database
        editing = true
    }
    
    init( duke_person: DukePerson, database: ModelData){
        self.Duke_Class = DukeClass(name: "TempClass", description: "", startTime: "12pm", endTime: "1:45pm", isEnd: false, lastModified: .now, address: "anywhere", roomNumber: "None")
        self.Duke_Person = duke_person
        self.DataBase = database
    }

    
    func saveClass(name: String, description: String, startTime: String, endTime: String, lastModified: Date, address: String, roomNumber: String) -> Bool {
        //TODO: add data validation, returns False if any string not valid
        self.Duke_Class.name = name
        self.Duke_Class.description = description
        self.Duke_Class.startTime = startTime
        self.Duke_Class.endTime = endTime
        self.Duke_Class.lastModified = lastModified
        self.Duke_Class.address = address
        self.Duke_Class.roomNumber = roomNumber
        if editing {
            return DataBase.update_person_class(person_to_update: self.Duke_Person, class_to_update: self.Duke_Class)
        }
        else {
            return DataBase.add_person_class(person_to_update: self.Duke_Person, class_to_add: self.Duke_Class)
        }
    }
     
     func removeClass()-> Bool {
         DataBase.remove_person_class(person_to_update: self.Duke_Person, class_to_remove: self.Duke_Class)
     }
    
}
