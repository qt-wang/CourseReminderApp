//
//  DataBase.swift
//  watchapp WatchKit Extension
//
//  Created by Loaner on 2/27/22.
//

import Foundation
//var myown : DukePerson  //User info
final class ModelData: ObservableObject {
    
    private static var class_one = DukeClass(name: "ECE564", description: "Richard Telford's class", startTime: "9pm", endTime: "1:45pm", isEnd: false, lastModified: .now, address: "anywhere", roomNumber: "hudson hall 125")
    private static var class_two = DukeClass( name: "ECE551", description: "Drew's class", startTime: "11pm", endTime: "1:45pm", isEnd: false, lastModified: .now, address: "anywhere", roomNumber: "hudson hall 125")
    private static var class_three = DukeClass( name: "ECE560", description: "Tyler's class", startTime: "12pm", endTime: "2:45pm", isEnd: false, lastModified: .now, address: "anywhere", roomNumber: "hudson hall 125")
    
    
    private static var defaultDukeClasses: [String : DukeClass] = [
        "\(class_one.id)" : class_one,
        "\(class_two.id)" : class_two,
        "\(class_three.id)" : class_three
    ]
    
    private static var feng = DukePerson(firstName: "feng", lastName: "wang", description: "test person", FriendList: [], Schedule: defaultDukeClasses, netId: "fw84")
    private static var fernanda = DukePerson(firstName: "fernanda", lastName: "Corona", description: "test person", FriendList: ["\(feng.netId)"], Schedule: defaultDukeClasses, netId: "fec6")
    private static var quitong = DukePerson( firstName: "qiutong", lastName: "wang", description: "test person", FriendList: ["\(feng.netId)", "\(fernanda.netId)"], Schedule: defaultDukeClasses, netId: "q")
    
    private static var defaultDukePeople : [String : DukePerson] = [
        "\(feng.netId)" : feng,
        "\(fernanda.netId)" : fernanda,
        "\(quitong.netId)" : quitong
    ]
    
    

    @Published var dukeClasses = defaultDukeClasses
    @Published var dukePeople = defaultDukePeople
    @Published var myself = feng
    
    
    
    
    //put
    
    //update a duke Person
    
    func update_person(person_to_update : DukePerson)-> Bool{
        print("database: update person")
        dukePeople[person_to_update.netId] = person_to_update
        update_person_remote(person_to_update: person_to_update)
        myself = person_to_update
        return true
    }
    
    func add_person(person_to_add : DukePerson)-> Bool{
        print("database: add person")
        dukePeople["\(person_to_add.netId)"] = person_to_add
        update_person_remote(person_to_update: person_to_add)
        return true
    }
    
    func remove_person(person_to_remove : DukePerson)-> Bool{
        print("database: remove person")
        dukePeople.removeValue(forKey: "\(person_to_remove.netId)")
        remove_person_remote(person_to_remove: person_to_remove)
        return true
    }
    
    func remove_all()-> Bool{
        dukePeople.removeAll()
        remove_all_remote()
        return true
    }
    
    func initialize(){//initilize the remote database
        
        
    }
    
    
    //update a certain class of a person
    //return false if failed
    func update_person_class (person_to_update : DukePerson, class_to_update : DukeClass) -> Bool{
        print("database: update person class")
        var person_updated = person_to_update
        person_updated.Schedule["\(class_to_update.id)"] = class_to_update
        dukePeople["\(person_updated.netId)"] = person_updated
        update_person_remote(person_to_update: person_updated)
        myself = person_updated //TODO: retrieve person from api
        return true
    }
    
    
    //add a certain class of a person
    //return false if failed
    func add_person_class(person_to_update : DukePerson, class_to_add : DukeClass) -> Bool{
        print("database: add person class")
        return update_person_class(person_to_update: person_to_update, class_to_update: class_to_add)
    }
    
    //remove a certain class of a person
    //return false if failed
    func remove_person_class(person_to_update : DukePerson, class_to_remove : DukeClass) -> Bool{
        print("database: remove person class")
        var person_updated = person_to_update
        person_updated.Schedule.removeValue(forKey: "\(class_to_remove.id)")
        dukePeople["\(person_updated.netId)"] = person_updated
        update_person_remote(person_to_update: person_updated)
        myself = person_updated //TODO: retrieve person from api
        return true
    }

    
    
}
