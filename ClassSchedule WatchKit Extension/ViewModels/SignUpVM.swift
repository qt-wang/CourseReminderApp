//
//  SignUpVM.swift
//  ClassSchedule WatchKit Extension
//
//  Created by student on 3/14/22.
//

import Foundation
import Combine
import SwiftUI


class SignUpVM: ObservableObject {

    @ObservedObject var DataBase: ModelData

    init(database: ModelData){
        self.DataBase = database
    }

    func add_new_person(firstName: String, lastName: String, description: String, netid: String)-> Bool {
        var new_person =  DukePerson(firstName: firstName, lastName: lastName, description: description, FriendList: [], Schedule: [:], netId: netid)
        return DataBase.add_person(person_to_add : new_person)
    }
    
}
