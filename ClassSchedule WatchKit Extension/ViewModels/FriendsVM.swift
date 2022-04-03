//
//  FriendsVM.swift
//  ClassSchedule WatchKit Extension
//
//  Created by student on 3/14/22.
//

import Foundation
import Combine
import SwiftUI

class FriendsVM: ObservableObject {
    
    @Published var Duke_Person: DukePerson
    @ObservedObject var DataBase: ModelData

    init(duke_person: DukePerson, data_base: ModelData){
        self.Duke_Person = duke_person
        self.DataBase = data_base
      
    }
    
    func person_is_friend(student: DukePerson) -> Bool {
        return self.Duke_Person.FriendList.contains(student.firstName)
        
    }
    
    func change_friend_status(student: DukePerson)-> Bool {
        if person_is_friend(student: student) {
            if let first_ind = self.Duke_Person.FriendList.firstIndex(of: student.firstName) {
                self.Duke_Person.FriendList.remove(at: first_ind)
            }
            return DataBase.update_person(person_to_update : self.Duke_Person)
        }
        else {
            self.Duke_Person.FriendList.append(student.firstName)
            return DataBase.update_person(person_to_update : self.Duke_Person)
        }
        
    }
    
    func add_friend_class_to_schedule(friendClass: DukeClass)-> Bool {
        return self.DataBase.add_person_class(person_to_update: self.Duke_Person, class_to_add: friendClass)
        
    }
    
    
}
